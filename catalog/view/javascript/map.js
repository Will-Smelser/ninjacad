var map = (function(){
	return {
		mapContainer : "mapDiv", 
		mapDefaultOptions : {
			disableKeyboardInput : true,
			showMapTypeSelector : false,
			credentials: "AvyHdctVlu2FCkd5VFf5hPaTxvFBkf0QcpmLnYSB7-Uglb-TwwtCOleTPGByaXaj", 
			zoom:20, 
			center: null,
			mapTypeId:Microsoft.Maps.MapTypeId.aerial,
			enableSearchLogo:false
			
		},
		defaultLat :40.03649941214659,
		defaultLong : -83.01738390888278,
		defaultLocation : null, //set at initialization
		
		
		map:null,
		
		pushpin : {
			parent : null,//parent object
			obj : null, //the bing pushpin object
			
			/**
			 * User overwrites this, passes in lat,long as paramters
			 */
			userfunc: {},
			update : function(location){
				
				this.obj.setLocation(location);
				this.parent.map.setView({center:location});
				
				if(typeof this.userfunc == 'function')
					this.userfunc(location.latitude,location.longitude);
			},
			
			dragEnd : function(e){
				var scope = this;
				
				//check that the search manager is loaded
				if(!this.parent.search.loaded){
					//TODO handle this better
					console.log("Search Failed");
				}
				
				var userData = new scope.parent.geocode.userData(scope.parent.geocode, scope.parent.geocode.reverseGoal);
				userData.location = e.target.getLocation();
					
				var reverseGeocodeRequest = {
						location: e.target.getLocation(), 
						count: 5, 
						callback: scope.parent.geocode.callback, 
						errorCallback: scope.parent.geocode.error,
						userData:userData
				};
				
				this.parent.search.searchManager.reverseGeocode(reverseGeocodeRequest);
				this.update(e.target.getLocation());
			}
		},
		
		geocode : {
			parent : null,
			geoLocationProvider : null,
			
			/**
			 * scope The scope to call goal in
			 * goal A function to be called on success
			 *
			 * return Object
			 */
			userData : function(scope, goal){
				return {scope:scope,goal:goal};
			},
			
			/**
			 *  Called from geocode (search by address) and 
			 *  reverseGeocode (search by lat,log) lookups
			 */
			callback : function(data, userData){
		    	var scope = userData.scope;
		    	    	
		   		var result = data;
		   		var msdnEnum = Microsoft.Maps.Search.MatchCode;
		   		
		   		//check the match code
		   		switch(result.matchCode){
		   		case msdnEnum.none://none
		   			//TODO handle this
		   			break;
		   		case msdnEnum.ambigous:
		   			//TODO handle this
		   			break;
		   		case msdnEnum.upHierarchy:// found by broader search
		   			//TODO handle this
		   			break;
		   		case msdnEnum.modified:
		   		case msdnEnum.good:
		   			userData.goal.call(scope, result, userData);
		   		}	
		    },
		    error : function(data){
		    	//TODO handle the error
		    	console.log("geocode error",data);
		    },
		    
		    /**
		     * Executed by callback, geocode from address
		     */
		    addressGoal: function(place, userData){
		    	userData.scope.parent.pushpin.update(place.location);
		    },
		    
		    /**
		     * Called by callback, reverseGeocode from lat,long.  The
		     * information passed back is based on the address, not the
		     * lat,long passed in.
		     */
		    reverseGoal : function(place, userData){
		    	console.log('do nothing');
		    },
		    
		    /**
		     * Geocode address
		     */
			geocode : function(address){
		    	
		    	var scope = this;
		    	var searchRequest = {
		    		where:address, count: 5, 
		    		callback:function(data, userData){
		    			if(data.results.length > 0){
		    				scope.callback(data.results[0],userData);
		    			}else{
		    				//TODO handle not results error
		    			}
		    		}, 
		    		errorCallback: scope.error, 
		    		userData: new scope.userData(scope, 
		    				scope.addressGoal)
		    	};
		        scope.parent.search.searchManager.geocode(searchRequest);
		    },
		    
		    geocode2 : function(address, successCallback, failCallback, scope){
		    	var searchRequest = {
		    		where:address, count: 5, 
		    		callback:function(GeocodeResult, userData){
		    			successCallback.call(scope, GeocodeResult);
		    		}, 
		    		/*http://msdn.microsoft.com/en-us/library/hh868060.aspx
		    		 * geocodeResult is a geocodeRequestOptions object, not
		    		 * the GeocodeResult in normal callback
		    		 */
		    		errorCallback: function(geocodeResult){
		    			failCallback.call(scope, geocodeResult);
		    		}
			    };
		    	scope.parent.search.searchManager.geocode(searchRequest);
		    },
		    
		    reverseGeocode : function(lat,long, callback){
		    	var userData = new this.userData(this, this.reverseGoal);
				var reverseGeocodeRequest = {
						location: new Microsoft.Maps.Location(lat, long), 
						count: 5, 
						callback: callback, 
						errorCallback: this.error,
						userData:userData
				};
				var searchManager = new Microsoft.Maps.Search.SearchManager(this.parent.map);
				searchManager.reverseGeocode(reverseGeocodeRequest);
		    }
		},
		
		search:{
			searchManager : null,
			loaded : false,
		},
		
		init : function(mapDiv, settings){
			var scope = this;
			
			this.mapContainer = mapDiv;
			
			//because we are using event, we may often times need access to the parent object
			this.pushpin.parent = scope;
			this.geocode.parent = scope;
			
			this.defaultLocation = new Microsoft.Maps.Location(scope.defaultLat,scope.defaultLong);
			this.mapDefaultOptions.center = this.defaultLocation;
			
			$.extend(scope.mapDefaultOptions, settings);
			this.map = new Microsoft.Maps.Map(document.getElementById(scope.mapContainer), scope.mapDefaultOptions);
			
			//http://msdn.microsoft.com/en-us/library/gg427615.aspx
			this.pushpin.obj = new Microsoft.Maps.Pushpin(scope.defaultLocation,{draggable:true});
			
			Microsoft.Maps.Events.addHandler(scope.pushpin.obj, 'mouseup', 
				function(e){
					//object expect to be called within their own scope
					scope.pushpin.dragEnd.call(scope.pushpin,e);
				}
			);
			this.map.entities.push(scope.pushpin.obj);
			
			//center the map on location
			//http://msdn.microsoft.com/en-us/library/hh125833.aspx
			this.geocode.geoLocationProvider = new Microsoft.Maps.GeoLocationProvider(scope.map);
			
			this.geocode.geoLocationProvider.getCurrentPosition({showAccuracyCircle:false,updateMapView:false,
        		successCallback:function(data){
        			scope.pushpin.update(data.center);
        		}
        	});
			
			//load the search
			Microsoft.Maps.loadModule("Microsoft.Maps.Search",{ callback: function(){
				scope.search.searchManager = new Microsoft.Maps.Search.SearchManager(scope.map);
				scope.search.loaded = true;
			}});
			
		}
	};
}());
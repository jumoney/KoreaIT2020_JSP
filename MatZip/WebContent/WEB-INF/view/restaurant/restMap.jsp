<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="sectionContainerCenter">
	<div id="mapContainer" style="width: 100%; height: 100%;"></div>

	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b325594ff69d0653086e2caa183e5ba1"></script>
	<script>	
		const options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(35.865532, 128.593404), //지도의 중심좌표.
			level : 5
		//지도의 레벨(확대, 축소 정도)
		};

		const map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
		
		console.log(map.getCenter());

		function getRestaurantList() {
			axios.get('/restaurant/getList').then(function(res) {
				console.log(res.data);
				res.data.forEach(function(item) {
					const na = {
							'Ga': item.lng,
							'Ha': item.lat
					}
					
					// 마커가 표시될 위치입니다 
					var markerPosition  = new kakao.maps.LatLng(na);
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});

					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
				});	
			});
		} 
		getRestaurantList();
		/*
			na: {
				Ga:
				Na:
			}
		
		*/
		
	</script>
</div>
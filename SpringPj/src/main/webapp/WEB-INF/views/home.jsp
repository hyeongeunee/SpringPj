<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../../resources/css/nav.css">
<link rel="stylesheet" href="../../resources/css/map.css">
<link rel="stylesheet" href="../../resources/css/footer.css">
<link rel="stylesheet" href="../../resources/css/btn.css">
<style>
    /*#canvas {*/
    /*    border: 2px dashed #92AAB0;*/
    /*    width: 850px;*/
    /*    height: 60px;*/
    /*    color: #92AAB0;*/
    /*    padding: 10px 10px 10px 10px;*/
    /*    font-size: 200%;*/
    /*    display: table-cell;*/
    /*    position: relative;*/
    /*    top: 30%;*/
    /*    left: 50%;*/
    /*    transform: translate(-50%, -50%);*/
    /*    margin-top: -130px;*/
    /*    margin-bottom: 20px;*/
    /*}*/

    .container {
        margin: auto;
        text-align: center;
        justify-content: center;
        align-items: center;
        display: flex;
        flex-direction: column;
    }

    #title {
        margin-top: -100px;
    }
</style>
<%@include file="../../resources/include/navbar.jsp" %>
<body>
<div class="container">
    <div id="title">
        <img src="/resources/img/title.png" alt="Food Display" id="display">
    </div>

    <input class="c-checkbox" type="checkbox" id="checkbox">
    <div class="c-formContainer">
        <form class="c-form" action="">
            <input class="c-form__input" placeholder="Keyword" type="search" style="text-align: center"
                   id="c-form__input">
            <label class="c-form__buttonLabel" for="checkbox">
                <button class="c-form__button" type="button" id="c-form__button">Submit</button>
            </label>
            <label class="c-form__toggle" for="checkbox" data-title="Start"></label>
        </form>
    </div>

    <div class="map_container">
        <div class="map_wrap">
            <div id="map" style="width:900px;height:500px;position:relative;overflow:hidden;text-align: center"></div>
            <div id="menu_wrap" class="bg_white">
                <div class="option">
                    <div>
                        <form onsubmit="searchPlaces(); return false;">
                            <strong>Keyword :</strong> <input type="text" id="keyword" size="15">
                            <button type="submit">검색하기</button>
                        </form>
                    </div>
                </div>
                <hr>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../resources/include/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde7da8120806d1e7a8f56effd701825&libraries=services"></script>
<script src="../../resources/js/map.js"></script>
<script>

    $("ul a").on("click", (e) => {
        $("ul a").removeClass("active");
        $(e.target).addClass("active");
    });

    const title = document.getElementById('title');
    const spinButton = document.querySelector('.c-form__button');
    const display = document.getElementById('display');
    const toggle = document.querySelector('.c-form__toggle');
    const formButtonLabel = document.querySelector('.c-form__buttonLabel');

    const foodImages = [];
    for (let i = 0; i < 24; i++) {
        let tmp = new Image();
        tmp.src = "/resources/img/food/" + i + ".png";
        foodImages.push(tmp);
    }

    let interval;
    let isSpinning = false;
    let stoppedImageIndex; // 멈춘 이미지의 인덱스 번호 저장 변수

    function startSpinning() {
        isSpinning = true;
        spinButton.disabled = true; // 버튼 비활성화

        interval = setInterval(() => {
            const randomIndex = Math.floor(Math.random() * foodImages.length);
            display.src = foodImages[randomIndex].src;
        }, 50); // 매 초마다 사진 변경
    }

    function stopSpinning() {
        clearInterval(interval);
        interval = null;
        isSpinning = false;

        // 멈춘 이미지의 인덱스 번호 저장
        const stoppedImageSrc = display.src;
        stoppedImageIndex = foodImages.findIndex((image) => image.src === stoppedImageSrc);

        displayStoppedImage();
        formButtonLabel.value = getDisplayedImageValue();
    }

    toggle.addEventListener('click', () => {
        if (!isSpinning) {
            startSpinning();
            setTimeout(() => {
                stopSpinning();
            }, 5000);
        } else {
            stopSpinning();
        }
    });

    // 마커를 담을 배열입니다
    var markers = [];

    var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.4987464, 127.03169), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    var markerPosition = new kakao.maps.LatLng(37.4987464, 127.03169);
    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35);
    // 마커 이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    //
    var marker = new kakao.maps.Marker({
        position: markerPosition,
        image: markerImage
    });
    //
    // var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    marker.setMap(map);

    function getDisplayedImageValue() {
        switch (stoppedImageIndex) {
            case 0:
                return "초밥";
            case 1:
                return "짜장면";
            case 2:
                return "짬뽕";
            case 3:
                return "김치찌개";
            case 4:
                return "냉면";
            case 5:
                return "치킨";
            case 6:
                return "햄버거";
            case 7:
                return "스테이크";
            case 8:
                return "라면";
            case 9:
                return "떡볶이";
            case 10:
                return "회";
            case 11:
                return "피자";
            case 12:
                return "족발";
            case 13:
                return "보쌈";
            case 14:
                return "삼겹살";
            case 15:
                return "비빔밥";
            case 16:
                return "파스타";
            case 17:
                return "닭갈비";
            case 18:
                return "제육볶음";
            case 19:
                return "생선구이";
            case 20:
                return "돈까스";
            case 21:
                return "랍스터";
            case 22:
                return "볶음밥";
            case 23:
                return "국밥";
            default:
                return "밥집";
        }
    }

    function displayStoppedImage() {
        const value = getDisplayedImageValue();
        document.querySelector("#c-form__input").value = value;
        const submitButton = document.getElementById('c-form__button');
        submitButton.disabled = false; // 버튼을 비활성화
        document.querySelector("#c-form__button").addEventListener("click", () => {
            var ps = new kakao.maps.services.Places();
            var infowindow = new kakao.maps.InfoWindow({zIndex: 1});
            searchPlaces();

            function searchPlaces() {
                var keyword = "삼원타워 근처" + document.querySelector("#c-form__input").value;

                if (!keyword.replace(/^\s+|\s+$/g, '')) {
                    alert('키워드를 입력해주세요!');
                    return false;
                }

                ps.keywordSearch(keyword, placesSearchCB);
            }
        })
        console.log("Value:", value);
    }

    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            alert('검색 결과가 존재하지 않습니다.');
        } else if (status === kakao.maps.services.Status.ERROR) {
            alert('검색 결과 중 오류가 발생했습니다.');
        }
    }

    function displayPlaces(places) {

        var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function (marker, title) {
                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    displayInfowindow(marker, title);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                });

                itemEl.onmouseover = function () {
                    displayInfowindow(marker, title);
                };

                itemEl.onmouseout = function () {
                    infowindow.close();
                };
            })(marker, places[i].place_name);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {

        var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>' +
                '   <span class="jibun gray">' + places.address_name + '</span>';
        } else {
            itemStr += '    <span>' + places.address_name + '</span>';
        }

        itemStr += '  <span class="tel">' + places.phone + '</span>' +
            '</div>';

        el.innerHTML = itemStr;
        el.className = 'item';

        return el;
    }

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        var homeMarkerPosition = new kakao.maps.LatLng(37.4987464, 127.03169),
            homeSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
            homeImageSize = new kakao.maps.Size(36, 37),
            homeImgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            homeMarkerImage = new kakao.maps.MarkerImage(homeSrc, homeImageSize, homeImgOptions),
            homeMarker = new kakao.maps.Marker({
                position: position,
                image: homeMarkerImage
            })

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다
        markers.push(homeMarker);

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
        }

        for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function (i) {
                    return function () {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }

    document.querySelector("form").addEventListener("submit", (event) => {
        event.preventDefault(); // 폼 제출 기본 동작 막기

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places();

        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

        // 키워드로 장소를 검색합니다
        searchPlaces();

        // 키워드 검색을 요청하는 함수입니다
        function searchPlaces() {
            var keyword = "삼원타워 근처" + document.getElementById('keyword').value;

            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword, placesSearchCB);
        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 존재하지 않습니다.');
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 결과 중 오류가 발생했습니다.');
            }
        }

        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var listEl = document.getElementById('placesList'),
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(),
                bounds = new kakao.maps.LatLngBounds(),
                listStr = '';

            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                    marker = addMarker(placePosition, i),
                    itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(placePosition);

                // 마커와 검색결과 항목에 mouseover 했을때
                // 해당 장소에 인포윈도우에 장소명을 표시합니다
                // mouseout 했을 때는 인포윈도우를 닫습니다
                (function (marker, title) {
                    kakao.maps.event.addListener(marker, 'mouseover', function () {
                        displayInfowindow(marker, title);
                    });

                    kakao.maps.event.addListener(marker, 'mouseout', function () {
                        infowindow.close();
                    });

                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, title);
                    };

                    itemEl.onmouseout = function () {
                        infowindow.close();
                    };
                })(marker, places[i].place_name);

                fragment.appendChild(itemEl);
            }

            // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        }

        // 검색결과 항목을 Element로 반환하는 함수입니다
        function getListItem(index, places) {

            var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

            if (places.road_address_name) {
                itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' + places.address_name + '</span>';
            } else {
                itemStr += '    <span>' + places.address_name + '</span>';
            }

            itemStr += '  <span class="tel">' + places.phone + '</span>' +
                '</div>';

            el.innerHTML = itemStr;
            el.className = 'item';

            return el;
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, idx, title) {
            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            var homeMarkerPosition = new kakao.maps.LatLng(37.4987464, 127.03169),
                homeSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
                homeImageSize = new kakao.maps.Size(36, 37),
                homeImgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                homeMarkerImage = new kakao.maps.MarkerImage(homeSrc, homeImageSize, homeImgOptions),
                homeMarker = new kakao.maps.Marker({
                    position: position,
                    image: homeMarkerImage
                })

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker);  // 배열에 생성된 마커를 추가합니다
            markers.push(homeMarker);

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
        function displayPagination(pagination) {
            var paginationEl = document.getElementById('pagination'),
                fragment = document.createDocumentFragment(),
                i;

            // 기존에 추가된 페이지번호를 삭제합니다
            while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild(paginationEl.lastChild);
            }

            for (i = 1; i <= pagination.last; i++) {
                var el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;

                if (i === pagination.current) {
                    el.className = 'on';
                } else {
                    el.onclick = (function (i) {
                        return function () {
                            pagination.gotoPage(i);
                        }
                    })(i);
                }

                fragment.appendChild(el);
            }
            paginationEl.appendChild(fragment);
        }

        // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
        // 인포윈도우에 장소명을 표시합니다
        function displayInfowindow(marker, title) {
            var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

            infowindow.setContent(content);
            infowindow.open(map, marker);
        }

        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }
    });

</script>

</body>

</html>

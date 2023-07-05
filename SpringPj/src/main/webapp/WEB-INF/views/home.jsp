<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<style>
    @import url("https://fonts.googleapis.com/css?family=Oswald");

    :root {
        --background: #FFF;
        --text: #000;
        --highlight: #39AC4C;
    }

    body {
        background: var(--background);
        /*display: flex;*/
        height: 100%;
        overflow: hidden;
        transition: 0.5s background ease;
    }

    .container {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }

    .navigation {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        display: flex;
        justify-content: center;
    }

    ul {
        display: flex;
        list-style-type: none;
        padding: 0;
    }

    ul a {
        margin: 10px 30px;
        position: relative;
        color: var(--text);
        font-family: "Oswald", sans-serif;
        font-size: 20px;
        text-transform: uppercase;
        text-decoration: none;
    }

    ul a:before {
        position: absolute;
        bottom: -2px;
        content: "";
        width: 100%;
        height: 3px;
        background: var(--highlight);
        transform: translateX(-100%);
        opacity: 0;
    }

    ul a:hover:before {
        opacity: 1;
        transition: 0.5s transform ease, 0.8s opacity ease;
        transform: translateX(0);
    }

    ul .active {
        color: var(--highlight);
    }

    ul .active:hover:before {
        opacity: 0;
    }

    #map {
        position: relative;
        text-align: center;
        top: 50%;
        left: 35%;
        transform: translate(-50%, -50%);
        margin-top: 300px;
    }

    #canvas {
        border: 2px dashed #92AAB0;
        width: 850px;
        height: 60px;
        color: #92AAB0;
        padding: 10px 10px 10px 10px;
        font-size: 200%;
        display: table-cell;
        position: relative;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        margin-top: 200px;
    }
</style>
<body>
<nav>
    <div class="container">
        <div class="navigation mb-3">
            <ul>
                <a href="#" class="active" target="_blank">Home</a>
                <a href="#" target="_blank">Info</a>
                <a href="#" target="_blank">Service</a>
                <a href="#" target="_blank">QnA</a>
            </ul>
        </div>
    </div>
</nav>
<%-- <div id="titleArea"> --%>
<%--     <div class="canvas-container"> --%>
<%--         <canvas id="title" width="1920" height="1080"></canvas> --%>
<%--     </div> --%>
<%-- </div> --%>
<div id="ranArea">
    <div class="canvas-container">
        <canvas id="canvas"></canvas>
    </div>
</div>
<div id="map" style="width:500px;height:400px;"></div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde7da8120806d1e7a8f56effd701825"></script>
<script>
    $("ul a").on("click", (e) => {
        $("ul a").removeClass("active");
        $(e.target).addClass("active");
    });

    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(37.4987464, 127.03169), //지도의 중심좌표.
        level : 5 //지도의 레벨(확대, 축소 정도)
    };
    var markerPosition = new kakao.maps.LatLng(37.4987464, 127.03169);
    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35);
    // 마커 이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    var marker = new kakao.maps.Marker({
        position: markerPosition,
        image   : markerImage
    });

    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    marker.setMap(map);

    const canvas = document.querySelector("#canvas");
    const context = canvas.getContext("2d");

</script>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../../resources/css/nav.css">
<link rel="stylesheet" href="../../resources/css/map.css">
<style>
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
<%@include file="../../resources/include/navbar.jsp"%>
<body>

<div id="ranArea">
    <div class="canvas-container">
        <canvas id="canvas"></canvas>
    </div>
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
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde7da8120806d1e7a8f56effd701825&libraries=services"></script>
<script src="../../resources/js/map.js"></script>
<script>
    $("ul a").on("click", (e) => {
        $("ul a").removeClass("active");
        $(e.target).addClass("active");
    });

    const canvas = document.querySelector("#canvas");
    const context = canvas.getContext("2d");

</script>
</body>

</html>

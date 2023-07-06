<%--
  Created by IntelliJ IDEA.
  User: acorn
  Date: 2023-07-06
  Time: 오후 4:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>canvas</title>
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
</head>
<body>
<div id="ranArea">
    <div class="canvas-container">
        <canvas id="canvas"></canvas>
    </div>
</div>
<script>
    const canvas = document.querySelector("#canvas");
    const context = canvas.getContext("2d");
    const foods = [];
    for (let i = 0; i < x; i++) {
        let tmp = new Image();
        tmp.src = "img/food"+i+".png"
        foods.push(tmp);
    }
</script>
</body>
</html>

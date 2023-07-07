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

    </style>
</head>
<body>
<div class="container">
    <div id="title">
        <img id="display" src="" alt="Food Display">
        <button id="spinButton">Spin!</button>
    </div>
</div>
<script>
    const title = document.getElementById('title');
    const spinButton = document.getElementById('spinButton');

    const foodImages = [];
    for (let i = 0; i < 24; i++) {
        let tmp = new Image();
        tmp.src = "/resources/img/food/" + i + ".png";
        foodImages.push(tmp);
    }

    let interval;
    let isSpinning = false;
    let result; // 멈춘 이미지의 src 저장 변수

    function startSpinning() {
        isSpinning = true;
        spinButton.disabled = true; // 버튼 비활성화

        const display = document.getElementById('display');

        interval = setInterval(() => {
            const randomIndex = Math.floor(Math.random() * foodImages.length);
            display.src = foodImages[randomIndex].src;
        }, 1000); // 매 초마다 사진 변경
    }

    function stopSpinning() {
        clearInterval(interval);
        interval = null;
        isSpinning = false;

        // 멈춘 이미지의 src 저장
        const display = document.getElementById('display');
        stoppedImageSrc = display.src;
    }

    spinButton.addEventListener('click', () => {
        if (!isSpinning) {
            spinButton.disabled = true; // 버튼 비활성화
            startSpinning();
            setTimeout(() => {
                stopSpinning();
                displayStoppedImage();
                spinButton.disabled = false; // 이미지 변경이 멈춘 후에 버튼 활성화
            }, 5000);
        } else {
            stopSpinning();
        }
    });

    // 페이지 로딩 후 사진 변경 시작
    window.addEventListener('load', () => {
        const display = document.getElementById('display');
        const randomIndex = Math.floor(Math.random() * foodImages.length);
        display.src = foodImages[randomIndex].src;
        interval = setInterval(() => {
            if (isSpinning) {
                const randomIndex = Math.floor(Math.random() * foodImages.length);
                display.src = foodImages[randomIndex].src;
            }
        }, 1000); // 매 초마다 사진 변경
    });

    function displayStoppedImage() {
        let value;
        switch (result) {
            case foodImages[0].src:
                value = "초밥";
                break;
            case foodImages[1].src:
                value = "짜장면";
                break;
            case foodImages[2].src:
                value = "짬뽕";
                break;
            case foodImages[3].src:
                value = "김치찌개";
                break;
            case foodImages[4].src:
                value = "냉면";
                break;
            case foodImages[5].src:
                value = "치킨";
                break;
            case foodImages[6].src:
                value = "햄버거";
                break;
            case foodImages[7].src:
                value = "스테이크";
                break;
            case foodImages[8].src:
                value = "라면";
                break;
            case foodImages[9].src:
                value = "떡볶이";
                break;
            case foodImages[10].src:
                value = "회";
                break;
            case foodImages[11].src:
                value = "피자";
                break;
            case foodImages[12].src:
                value = "족발";
                break;
            case foodImages[13].src:
                value = "보쌈";
                break;
            case foodImages[14].src:
                value = "삼겹살";
                break;
            case foodImages[15].src:
                value = "비빔밥";
                break;
            case foodImages[16].src:
                value = "파스타";
                break;
            case foodImages[17].src:
                value = "닭갈비";
                break;
            case foodImages[18].src:
                value = "제육볶음";
                break;
            case foodImages[19].src:
                value = "생선구이";
                break;
            case foodImages[20].src:
                value = "돈까스";
                break;
            case foodImages[21].src:
                value = "랍스터";
                break;
            case foodImages[22].src:
                value = "볶음밥";
                break;
            case foodImages[23].src:
                value = "국밥";
                break;
            default:
                value = "밥집";
                break;
        }
        console.log("Value:", value);
    }
    startSpinning();

</script>
</body>
</html>

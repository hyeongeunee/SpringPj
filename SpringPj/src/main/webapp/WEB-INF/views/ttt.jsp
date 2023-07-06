<%--
  Created by IntelliJ IDEA.
  User: acorn
  Date: 2023-07-06
  Time: 오후 5:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: sans-serif;
        }

        #display {
            margin-bottom: 20px;
            font-size: 24px;
        }

        button {
            font-size: 20px;
            padding: 10px 20px;
            margin-left: 100px;
        }

    </style>
</head>
<body>

<div id="display">Click the button!</div>
<button id="spinButton">Spin!</button>

<script>
    const display = document.getElementById('display');
    const spinButton = document.getElementById('spinButton');

    const words = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'];
    let interval;
    let isSpinning = false;

    spinButton.addEventListener('click', () => {
        if (isSpinning) {
            clearInterval(interval);
            interval = null;
            isSpinning = false;
            spinButton.textContent = 'Spin!';
            spinButton.disabled = false; // 버튼 활성화
        } else {
            isSpinning = true;
            spinButton.textContent = 'Wait!';
            spinButton.disabled = true; // 버튼 비활성화

            let counter = 0;
            interval = setInterval(() => {
                const randomIndex = Math.floor(Math.random() * words.length);
                display.textContent = words[randomIndex];
                counter++;

                if (counter >= 100) {
                    clearInterval(interval);
                    interval = null;
                    isSpinning = false;
                    spinButton.textContent = 'Spin!';
                    spinButton.disabled = false; // 버튼 활성화
                }
            }, 50);
        }
    });

    setTimeout(() => {
        if (isSpinning) {
            clearInterval(interval);
            interval = null;
            isSpinning = false;
            spinButton.textContent = 'Spin!';
            spinButton.disabled = false; // 버튼 활성화
        }
    }, 5000);
</script>
</body>
</html>

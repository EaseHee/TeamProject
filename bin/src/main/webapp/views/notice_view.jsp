<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지 사항</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        h1 {
            font-size: 36px;
            margin: 20px 0;
            border-bottom: 2px solid black;
            padding-bottom: 10px;
            width: 100%;
            box-sizing: border-box;
        }
        html {
            font-size: 10px;
        }
        .board_view {
            width: 90%;
            margin: 0 auto;
        }
        .board_view .title {
            padding: 20px 15px;
            font-size: 30px;
        }
        .board_view .info {
            padding: 15px;
            border-bottom: 1px solid #999;
            font-size: 0;
            text-align: right;
        }
        .board_view .info dl {
            display: inline-block;
            padding: 0 20px;
        }
        .board_view .info dl:first-child {
            padding-left: 0;
        }
        .board_view .info dl dt,
        .board_view .info dl dd {
            display: inline-block;
            font-size: 20px;
        }
        .board_view .info dl dd {
            margin-left: 10px;
            color: #777;
        }
        .board_view .cont {
            padding: 15px;
            border-bottom: 1px solid #000;
            line-height: 160%;
            font-size: 15px;
        }
        .action {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .action button {
            padding: 10px 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>공지사항</h1>
    </div>
    <div class="board_view">
        <div class="title">
            제목
            <div class="info">
                <dl>
                    <dt>2024.07.16</dt>
                    <dt>&nbsp;&nbsp;관리자</dt>
                </dl>
            </div>
        </div>
        <div class="cont">
            공지 내용<br>
            공지 내용<br>
            공지 내용<br>
            공지 내용<br>
            공지 내용<br>
            공지 내용<br>
        </div>
        <div class="action">
            <button>이전 글</button>
            <button>다음 글</button>
        </div>
    </div>
</body>
</html>
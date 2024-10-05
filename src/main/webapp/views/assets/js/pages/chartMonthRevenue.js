/**
 * 매출 현황 통계 그래프
 * [dashboard.jsp _ 월별 서비스 매출 현황 출력용 설정 변경]
 * 1. 페이지가 로드되면 서비스별 매출 현황 그래프 출력
 * 2. RevenueChart : 월별 서비스 수익 (x축: 1~12월 & y축: 수익액)
 * 3. 서비스 항목별 구분 (series name 속성으로 구분)
 */

/* Servlet에 요청, 응답 : fetch() */
class DashboardChart {

  constructor () {
    // 메인 화면 로드 시 매출 현황 그래프 초기화 
    if(this._isMainPage()) {
      this._fetchAndShowChart();
    };
  }

  // 메인 화면 여부 반환
  _isMainPage() {
    let path = window.location.pathname; ///TeamProject/views/dashboard.jsp
    let nowPage = path.substring(path.lastIndexOf("/")+1, path.lastIndexOf("."));
    console.log("[현재 페이지] : " + nowPage); 
    if (nowPage === "dashboard") {
      return true;
    } else {
      return false;
    }
  }

  _fetchAndShowChart() {
    fetch(`/TeamProject/dashboard?command=CHART_SERVICE`)
    .then(response => response.json())
    .then(json => {
      // test
      // console.log("dashboard_Chart.jsp", json);
      new RevenueChart()._getServiceRevenueChart(json);
    })
  }
}

/* 차트 속성 설정 클래스 */
class RevenueChart {
  constructor() {
    this.barOptions;
    this._setAttribute();
    this._setHeader();
  }

  _setAttribute() {
    this.color_main = "#435ebe";
    this.color_blue = "#7BD3EA";
    this.color_red = "#F6D6D6";
    this.color_green = "#A1EEBD";
    this.color_yellow = "#F6F7C4";
    this.colors = [this.color_blue, this.color_red, this.color_green, this.color_yellow]

    document.getElementById("revenue").style.boxSizing = "border-box";
    document.getElementById("revenue").setAttribute("position", "relative");
  }

  _setHeader() {
    document.getElementById("chart-title").innerText = "연간 서비스 매출액 통계";
  }

  _setOptions (series)  {
    this.barOptions = {
      /* 
        필요한 데이터의 형식 
        series: [
          {
            name: 서비스1,
            data: [서비스1의 1월 수익, 2월 수익, ... , 12월 수익]
          }, {
            name: 서비스2,
            data: [서비스2의 1월 수익, 2월 수익, ... , 12월 수익]
          }, ... 
        ]
          JSONObject: { 
            KEY : String (서비스명), 
            VALUE : JSONArray (월별 수익) <- ArrayList 
          }
      */
      series: series,

      // 막대 색상 배열
      colors: this.colors,
      chart: {
        type: "bar",
        width: "100%",
        height: "450",
        stacked: false, // 데이터 중첩 X
        /* 
        
        stacked: true, // 데이터 중첩 O (막대 하나에 모두 표시)
        stackType: "100%",  // 전체 범위 중 비율로 표기
        */
       
        toolbar: {
          show: true  // 마우스 올렸을 때 툴바 출력 여부
        },
      },

      // plotOptions : 차트 옵션 (line, bar, area, bubble, ... )
      plotOptions: {
        bar: {
          horizontal: false,
          borderRadius: 10,
          columnWidth: "80%",	// 막대 두께
          barHeight: "60%",   // 막대 높이
          dataLabels: {
            position: 'top'
          },
          spacing: 5, // 막대 간격 (단위 : px)
        },
      },

      // 막대 내부에 라벨(y축 값) 출력
      dataLabels: {
        enabled: false, // 데이터 포인트에 레이블 출력 여부 결정
        // 가로 위치 조정
        textAnchor: "middle",  // "start", "middle", "end"
        style: {
          color: this.color_main,
          fontSize: 10,
          fontWeight: "bold",
        },
        // 세로 위치 조정
        offsetY: 5,
        formatter: (val) => {
          /* 단위 : 만원 & 구분 : 1000 단위 "," */
          return parseInt(val / 10000).toLocaleString() + " 만원";
          /* stacked: true 인 경우 전체 비율 중 해당 데이터의 비율을 출력 */
          // return val.toFixed(0) + "%";
        },
      },

      // 막대의 테두리 획 s설정
      stroke: {
        show: true, 
        width: 0.3,
        colors: [this.color_main]
      },
      xaxis: {
        categories: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"], // x축 : 1~12월
        fontSize: 15,
        fontWeight: "bold",
        labels: {
          offsetY: 3, // x축 데이터 값
        }
      },

      // 범례 (서비스 항목)
      legend: {
        show: true,
        fontSize: '10px',
        position: "bottom",
        horizontalAlign: "left" ,
        floating: false,
        offsetX: 10,
        offsetY: -50,
        markers: {
          size: 25,
          fillColors: this.colors,
          offsetY: -20,
        },
      },
      
      yaxis: {
        title: {
          text: "(단위 : 만원)",
          // 글꼴 스타일 설정
          style: {
            fontSize: 10,
            fontWeight: "normal", // 기본값 : "bold"
          },
          rotate: 0, // 수평 
          // 조금씩 움직이기..! (원점 : (x: 20, y: 210) | y축 끝 : (x: 20, y: -200))
          offsetX: 15,
          offsetY: -195,
        },
        // y축 데이터 값 
        labels: {
          formatter: val => parseInt(val / 10000).toLocaleString(),
        },
        type: "numeric"
      },
      fill: {
        opacity: 1, // 불투명
      },
      // 마우스 올렸을 때 뜨는 창
      tooltip: {
        y: {
          formatter: val => parseInt(val / 10000).toLocaleString() + " 만원"
        },
      },
      /* 참고 : https://apexcharts.com/docs/options/chart/toolbar/ */
      export: { // 미적용.
        csv: {
          filename: this.title + ".csv",
        },
        svg: {
          filename: this.title + ".svg",
        },
        png: {
          filename: this.title + ".png",
        }
      }
    };
  }

   // 차트 생성 함수
   _getServiceRevenueChart (series) {
    // 그래프 옵션 설정
    this._setOptions(series);
    // 그래프 출력 메서드 호출
    new ApexCharts(document.querySelector("#revenue"), this.barOptions).render();
   }
}
  
new DashboardChart();

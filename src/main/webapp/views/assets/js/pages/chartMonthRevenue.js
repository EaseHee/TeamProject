/**
 * 매출 현황 통계 그래프
 * [dashboard.jsp _ 월별 서비스 매출 현황 출력용 설정 변경]
 * 1. 페이지가 로드되면 현재 달을 기준으로 서비스별 매출 현황 그래프 출력
 *    indexMonth 변수를 선언하여 이전 달, 다음 달 선택 기능. "비동기 처리"
 *    prevMonth / nextMonth 버튼 클릭 시 indexMonth 변수 값 증감.
 * 2. ServiceRevenueChart : 서비스 별 수익
 * 3. ServiceCountChart : 서비스별 월 시술 횟수
 */
class ServiceChart {

  constructor () {
    console.log("Service Chart Constructor");
    // *** JS 클래스에서는 생성자에서 멤버 변수를 선언한다. "this.변수명" ***
    this.indexMonth = 0;
    this._init();
    this._setEventHandler();
  }

  // 화면 로드 시 매출 현황 그래프 초기화 
  _init() {
    this._fetchAndShowChart();
  }

  _setEventHandler() {
    document.getElementById("prevMonth").addEventListener("click", () => {
      this.indexMonth += 1;
      this._fetchAndShowChart();
    });
    document.getElementById("nextMonth").addEventListener("click", () => {
      this.indexMonth -= 1;
      this._fetchAndShowChart();
    });
  }

  _fetchAndShowChart() {
    console.log("fetch Chart");

    fetch(`/TeamProject/dashboard?command=CHART_SERVICE&indexMonth=${this.indexMonth}`)
    .then(response => response.json())
    .then(json => {
      // test
      console.log("dashboard_Chard.jsp");
      console.log(json.service);
      if (json.revenue != null) {
        console.log(json.revenue);
        // JSONObject 객체를 반환하여 service, revenue 변수를 전달하여 함수 호출
        new RevenueChart()._getServiceRevenueChart(json.service, json.revenue);
      } 
      if (json.count != null) {
        new CountChart()._getServiceCountChart(json.service, json.count);
      }
    })
    
    /* 
    axios({
      url: `/TeamProject/dashboard?command=CHART_SERVICE&indexMonth=${this.indexMonth}`,
      method: 'get',
      command : 'CHART_SERVICE',
      indexMonth : this.indexMonth
      })
      .then(json => {
        // *** axios에서는 자체적으로 data라는 속성을 사용하고 있기 때문에 별도의 매개변수를 설정해야 한다. ***
        // *** 데이터에 접근할 때 .data 객체를 거쳐서 접근한다. ***
        new RevenueChart()._getServiceRevenueChart(json.data.service, json.data.revenue);
      })  
       */
    }
  
}


class RevenueChart {
  constructor() {
    this.barOptions;
    this.title = "월별 서비스 매출 현황";
    this.color = "#4b5fb9";
  }

  _setOptions (services, revenues/* , month */)  {
    this.barOptions = {
      series: [
        {
          name: "월 매출", // 해당 막대의 데이터 속성
          data: revenues, // y축 데이터
        }
      ],
      title: {
        text: this.title,
        align: "center",
        margin: 10,
        floating: false,
        style: {
          fontWeight: "bold",
          color: this.color
        }
      },
      chart: {
        type: "bar",
        width: "100%",
        height: 350,
        stacked: true,
        toolbar: {
          show: true
        }
      },
	  // plotOptions : 차트 옵션 (line, bar, area, bubble, ... )
      plotOptions: {
        bar: {
          horizontal: false,
          borderRadius: 10,
          borderRadiusApplication: "around",  // "around", "end" : radius 적용 범위 (around 둘 다 , end 한 곳만)
          borderRadiusWhenStacked: "last",    // "all", "last" : Stacked 되었을 경우 경계 반지름 처리 (last : 마지막만)
          columnWidth: "60%"		// 막대 두께
        },
      },
      dataLabels: {
        textAnchor: "middle",  // "start", "middle", "end"
        enabled: true, // 데이터 포인트에 레이블 출력 여부 결정
        formatter: (val) => {
          // 단위 : 만원 & 구분 : 1000 단위 ","  
          return parseInt(val/10000).toLocaleString() + " 만원";
        }
      },
      stroke: {
        show: true, // bar의 테두리(border) 표시 여부 
      },
      xaxis: {
        categories: services, // x축 데이터 (문자열 전달)
      },
      legend: {
		show: true,
        position: "bottom",
        offsetY: 10
      },
      yaxis: {
        title: {
          text: "(단위 : 만원)",
        },
        type: "numeric"
      },
      fill: {
        colors: this.color,
        opacity: 1,
      },
	  // 마우스 올렸을 때 뜨는 창
      tooltip: {
        y: {
          // 화살표 함수 정리
          formatter: val => parseInt(val/10000).toLocaleString() + " 만원"
        },
      },
      /* 참고 : https://apexcharts.com/docs/options/chart/toolbar/ */
      export: {
        csv: {
          filename: /* `${month}월 서비스별 매출 현황` */ this.title + ".csv",
          columnDelimiter: ", ",
          headerCategory: "서비스명",
          headerValue: "월 매출"
        },
        svg: {
          filename: this.title + ".svg"
        },
        png: {
          filename: this.title + ".png"
        }
      }
    };
  }
   // 차트 생성 함수
   _getServiceRevenueChart (services, revenues/* , month */) {
    // 그래프 옵션 설정
    this._setOptions(services, revenues/* , month */);
    // 그래프 출력 메서드 호출
    new ApexCharts(document.querySelector("#revenue"), this.barOptions).render();
   }

}

  // 서비스별 시술 횟수 통계 
class CountChart {
  constructor() {
    this.barOptions;
    this.title = "서비스별 월 시술 횟수";
    this.color = "#4b5fb9";
  }

  _setOptions (services, counts/* , month */)  {
    this.barOptions = {
      series: [
        {
          name: "시술 횟수", // 해당 막대의 데이터 속성
          data: counts, // y축 데이터
        }
      ],
      title: {
        text: this.title,
        align: "center",
        margin: 10,
        floating: false,
        style: {
          fontWeight: "bold",
          color: this.color
        }
      },
      chart: {
        type: "bar",
        width: "100%",
        height: 350,
        stacked: true,
        toolbar: {
          show: true
        }
      },
      plotOptions: {
        bar: {
          horizontal: false,
          borderRadius: 5,
          borderRadiusApplication: "end",  // "around", "end"
          borderRadiusWhenStacked: "all",    // "all", "last"
          columnWidth: "40%"
        },
      },
      dataLabels: {
        enabled: false, // 데이터 포인트에 레이블 출력 여부 결정
      },
      stroke: {
        show: true, // bar의 테두리(border) 표시 여부 
      },
      xaxis: {
        categories: services, // x축 데이터 (문자열 전달)
      },
      legend: {
        position: "right",
        offsetY: 10
      },
      yaxis: {
        title: {
          text: "(시술 횟수)"
        },
        type: "numeric"
      },
      fill: {
        colors: this.color,
        opacity: 1,
      },
      tooltip: {
        y: {
          formatter: function(val) {
            return val + " 회";
          },
        },
      },
      /* 참고 : https://apexcharts.com/docs/options/chart/toolbar/ */
      export: {
        csv: {
          filename: /* `${month}월 서비스별 매출 현황` */ this.title + ".csv",
          columnDelimiter: ", ",
          headerCategory: "서비스명",
          headerValue: "시술 횟수"
        },
        svg: {
          filename: this.title + ".svg"
        },
        png: {
          filename: this.title + ".png"
        }
      }
    };
    }
    _getServiceCountChart(services, counts) {
    this._setOptions(services, counts);
  
    new ApexCharts(document.querySelector("#count"), this.barOptions).render();
    }
}
  
  
new ServiceChart();
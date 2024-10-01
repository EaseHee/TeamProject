// // dashboard.jsp _ 월별 서비스 매출 현황 출력용 설정 변경
class ServiceChart {

  constructor () {
    console.log("Service Chart Constructor");
    // *** JS 클래스에서는 생성자에서 멤버 변수를 선언한다. ***
    this.indexMonth = 0;
    this._init();
    this._setEventHandler();
  }

  _init() {
    console.log("ServiceChart init");

    this._fetchAndShowChart();
  }

  _setEventHandler() {
    document.getElementById("prevMonth").addEventListener("click", () => {
      console.log("prevMonth Click");

      this.indexMonth += 1;
      this._fetchAndShowChart();
    });
    document.getElementById("nextMonth").addEventListener("click", () => {
      console.log("nextMonth Click");

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
      console.log(json.revenue);
      // JSONObject 객체를 반환하여 service, revenue 변수를 전달하여 함수 호출
      new RevenueChart()._getServiceRevenueChart(json.service, json.revenue);
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
  }

  _setOptions (services, revenues)  {
    this.barOptions = {
      series: [
        {
          name: "Revenue", // 해당 막대의 데이터 속성
          data: revenues, // y축 데이터
        }
      ],
      chart: {
        type: "bar",
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: "55%",
          endingShape: "rounded",
        },
      },
      dataLabels: {
        enabled: true, // 데이터 포인트에 레이블 출력 여부 결정
      },
      stroke: {
        show: false, // bar의 테두리(border) 표시 여부 
      },
      xaxis: {
        categories: services, // x축 데이터 (문자열 전달)
      },
      yaxis: {
        title: {
          text: "(단위 : 만원)",
        },
      },
      fill: {
        opacity: 1,
      },
      tooltip: {
        y: {
          formatter: function(val) {
            return val + " 만원";
          },
        },
      },
    };
   }
   // 외부 호출용 함수
   _getServiceRevenueChart (services, revenues) {
    // 그래프 옵션 설정
    this._setOptions(services, revenues);
    // 그래프 출력 메서드 호출
    new ApexCharts(document.querySelector("#bar"), this.barOptions).render();
   }
}

new ServiceChart();
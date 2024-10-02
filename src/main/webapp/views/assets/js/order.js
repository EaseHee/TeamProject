let chooseBsort = async function (){
	const Bsort = document.getElementById("Bsort");
	const url = 'http://localhost:8080/TeamProject/DashProductServlet';
	axios.post(url, {
		product_B_code : Bsort.value
	})
};



//funciones para ocultar y aparecer el sidebar
if (screen.width <480) {
    	document.getElementById("mySidenav").style.width = "0";
    	document.getElementById("main").style.marginLeft= "0";
}else
{
	$('#close-link').addClass('hidden');
	$('#btnOpciones').addClass('hidden');
}

function openNav() {
	if (screen.width <480) {
		document.getElementById("mySidenav").style.width = "100%";
		document.getElementById("main").style.marginLeft = "250px";
		document.getElementById("mySidenav").style.height = "100%";
	}else
	{
		document.getElementById("mySidenav").style.width = "250px";
		document.getElementById("main").style.marginLeft = "250px";
		document.getElementById("mySidenav").style.height = "auto";
	}
}

function closeNav() {
	document.getElementById("mySidenav").style.width = "0";
	document.getElementById("main").style.marginLeft= "0";
	$("#mySidenav").removeClass("sidenav-small");
}
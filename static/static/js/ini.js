function parseCustomToUTC(s) {
    var datevals = s.split('.');
    var date = new Date(datevals[2], (datevals[1]-1), datevals[0]);
    return (date.setUTCSeconds(0));
}

(function($) {
	    $.fn.goTo = function() {
	         $('html, body').animate({
	         scrollTop: $(this).offset().top + 'px'
	         }, 'medium');
        return this; // for chaining...
   }
})(jQuery);


function ShowCal(data) {
	var now = (new Date()).setUTCSeconds(0);
	var termine = data.termine;
	var events = 0;
    for (var i in termine) {
        if (parseCustomToUTC(termine[i].Datum) > (now-2*86400000)) {
		//	console.log(parseCustomToUTC(termine[i].Datum) +": " + (now-86400000))
            $('#ini-calendar > tbody').append("<tr><td>" + termine[i].Datum + "</td>"+
                                     "<td>" + termine[i].Uhrzeit + "</td>"+
                                     "<td>" + termine[i].name + "</td>"+
                                   "</tr>");
			events++;
        }
    }
	if (events != 0) {
	 $('#calendar').show() 
	}

}

var subtexts;

function ChangeSubtext(subtexts) {
	do {
	  var randomText = subtexts[Math.floor(Math.random()*subtexts.length)];
	} while (randomText == $('#subtext').text())
	
	$('#subtext').text(randomText).hide().fadeIn(750);
}

if ($('#calendar').length) {
  $('#calendar').ready(function() {
	  $.getJSON("static/js/termine.json", ShowCal);
	});
  setTimeout(function() {
	  $('#ininav').fadeIn('750');
  }, 1000);

  $.getJSON("static/js/subtexts.json", function(data) {
	  subtexts=data.subtexts;
  });
  setInterval(function(){
	  ChangeSubtext(subtexts)
  }, 10000);

}
//ShowCal();


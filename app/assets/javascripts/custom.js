
$('.dropdown-menu:hover').parent().css('background:#B81D22');

$( ".dropdown-menu" ).hover(
    function() {
        $( this ).parent('.dropdown').css('background:#B81D22');
    }, function() {
    }
);
ready = function() {
    $('.dropdown-menu:hover').parent().css('background:#B81D22');

    $(".dropdown-menu").hover(
        function () {
            $(this).parent('.dropdown').css('background:#B81D22');
        }, function () {
        }
    );

    var maxProductsHeight = Math.max.apply(null, $("div.product-desc").map(function ()
    {
        return $(this).outerHeight();
    }).get());

    $('div.product-desc').outerHeight(maxProductsHeight);

/*
    $('div.product').hover(function(){
       $(this).height($(this).height()+5);
        $(this).width($(this).width()+5);
        $(this).css('margin-bottom:0px');
    }, function(){
        $(this).height($(this).height()-5);
        $(this).width($(this).width()-5);
    });
*/
};

$(document).ready(ready);
$(document).on('page:load', ready);
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
$(function(){
  $('.stars-logged').raty({
    number: 10,
    score: function() {
      return $(this).attr('data-score');
    },
    click: function(score) {
      var product_id = $(this).attr('data-product-id');
      $.ajax ({
        url: '/rating',
        type: 'POST',
        data: {
          score: score,
          product_id: product_id
        }
      }).done(function (data){
        location.reload();
      });
    },
    path: '/assets/'
  });
});
$(function(){
  $('.stars').raty({
    number: 10,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/',
    click: function() {
    }
  });
});
$(function(d, s, id){
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s);
  js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.8&appId=788341004675923";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
$(function($){
  //Function to animate slider captions
  function doAnimations( elems ) {
    //Cache the animationend event in a variable
    var animEndEv = 'webkitAnimationEnd animationend';
    elems.each(function () {
      var $this = $(this),
      $animationType = $this.data('animation');
      $this.addClass($animationType).one(animEndEv, function () {
        $this.removeClass($animationType);
      });
    });
  }
  //Variables on page load
  var $myCarousel = $('#carousel-example-generic'),
    $firstAnimatingElems = $myCarousel
      .find('.item:first').find("[data-animation ^= 'animated']");
  //Initialize carousel
  $myCarousel.carousel();
  //Animate captions in first slide on page load
  doAnimations($firstAnimatingElems);
  //Pause carousel
  $myCarousel.carousel('pause');
  //Other slides to be animated on carousel slide event
  $myCarousel.on('slide.bs.carousel', function (e) {
    var $animatingElems = $(e.relatedTarget)
      .find("[data-animation ^= 'animated']");
    doAnimations($animatingElems);
  });
  $('#carousel-example-generic').carousel({
    interval:300,
    pause: "false"
  });
});

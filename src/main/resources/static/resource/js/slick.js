$(document).ready(function () {
    $('.player-bundle').slick({
        autoplay: false, // 자동 스크롤 사용 여부
        autoplaySpeed: 3000, // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
        slidesToShow: 4, // 보여지는 슬라이드 개수
        slidesToScroll: 4, // 넘어가는 슬라이드 개수
        dots: true, // 점 네비게이션 표시
        arrows: true,
        draggable: false, //드래그 가능 여부
        prevArrow: '<span class="slick-divider left slick-divider"></span><img class="arrow-left" src="../../resource/img/prev-article-arrow.png" /></img>',
        nextArrow: '<span class="slick-divider right slick-divider"></span><img class="arrow-right" src="../../resource/img/next-article-arrow.png" /></img>',
    });
});

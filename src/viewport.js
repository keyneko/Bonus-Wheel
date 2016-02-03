export default function viewport(vw) {
    var viewport = document.querySelector("meta[name=viewport]");
    var winWidths = (window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);
    var viewWidth = vw;
    var densityDpi = viewWidth / winWidths;
    densityDpi = densityDpi > 1 ? 300 * viewWidth * densityDpi / viewWidth : densityDpi;

    console.log("viewWidth: " + viewWidth + " / winWidths: " + winWidths);

    if (!isiOS()) {
        viewport.setAttribute('content', `width=${viewWidth}, target-densityDpi=${densityDpi}, user-scalable=no`);
    } else {
        viewport.setAttribute('content', `width=${viewWidth}, user-scalable=no`);
    }

    // function isWeixin() {
    //   var ua = navigator.userAgent.toLowerCase();
    //   if (ua.match(/MicroMessenger/i) == "micromessenger") {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }

    function isiOS() {
        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/iPhone|iPad|iPod/i)) {
            return true;
        } else {
            return false;
        }
    }
}

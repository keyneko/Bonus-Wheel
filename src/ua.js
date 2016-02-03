export default function ua(opts) {
  let userAgent   =   navigator.userAgent.toLowerCase()

  let isIpad      =   userAgent.match(/ipad/i           ) == "ipad"
  let isIphoneOs  =   userAgent.match(/iphone os/i      ) == "iphone os"
  let isMidp      =   userAgent.match(/midp/i           ) == "midp"
  let isUc7       =   userAgent.match(/rv:1.2.3.4/i     ) == "rv:1.2.3.4"
  let isUc        =   userAgent.match(/ucweb/i          ) == "ucweb"
  let isAndroid   =   userAgent.match(/android/i        ) == "android"
  let isCE        =   userAgent.match(/windows ce/i     ) == "windows ce"
  let isWM        =   userAgent.match(/windows mobile/i ) == "windows mobile"

  if (isIpad || isIphoneOs || isMidp || isUc7 || isUc || isAndroid || isCE || isWM) {
    if (opts && opts.mobile) {
      opts.mobile()
    }
  }
  else {
    if (opts && opts.pc) {
      opts.pc()
    }
  }

}
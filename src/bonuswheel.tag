import shuffle from 'lodash/collection/shuffle'
import sample from 'lodash/collection/sample'
import reject from 'lodash/collection/reject'
import drop from 'lodash/array/drop'
import fill from 'lodash/array/fill'
import assign from 'lodash/object/assign'
import random from 'lodash/number/random'
import Tweenable from 'shifty'
import randomColor from 'random-hex-color'

<bonuswheel>
  <div name='wheelpies' class="pies">
    <div each={{pies}} 
         class='hold'  
         style='z-index: {{ z }};
                transform: rotate({{ start }}deg);
                -webkit-transform: rotate({{ start }}deg)' >
      <div class='pie' 
           style='background-color: {{ color }};
                  transform: rotate({{ end - start }}deg);
                  -webkit-transform: rotate({{ end - start }}deg)' >
        <!-- <label style="left: {{ (1 - Math.tan((end - start) / 180 / 2)) * 600 }}px;
                     transform: rotate({{ -(end - start) / 2 }}deg);
                     -webkit-transform: rotate({{ -(end - start) / 2 }}deg)">
          {{id}}
        </label> -->
      </div>
    </div>
  </div>

  <a class="btn-start" 
     name="wheelstart" 
     onclick={{start}} 
     disabled={{disabled?'disabled':''}}></a>

  <div class="tips">
    <div each={{pies}} 
         class="cube {{ parent.atari==id ? 'atari':'' }}"
         style='background-color: {{ color }};
                width: {{ 100 / pies.length }}%;
                ' >
      {{id}}
    </div>
  </div>

  <style scoped>
    :scope {
      display: block;
      width: 600px;
      height: 600px;
      /*box-shadow: 0 0 2rem red;*/
      border-radius: 50%;
      position: relative;
      z-index: 1;
      }
      .pies {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background-color: rgba(200,200,200,.95);
        }
        .pies:after {
          content: "";
          display: block;
          box-sizing: border-box;
          width: 100%;
          height: 100%;
          position: absolute;
          z-index: 19;
          border-radius: 50%; 
          border: 8px solid #C94914;
          }
      .hold {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        box-sizing: border-box;
        z-index: 9;
        clip: rect(0, 600px, 600px, 300px);
        transform: rotate(30deg);
        }
        .pie {
          width: 100%;
          height: 100%;
          border-radius: 50%;
          clip: rect(0, 300px, 600px, 0px);
          transform: rotate(90deg);
          background-color: red;
          position: absolute;
          }
          .pie label {
            color: white;
            text-shadow: 1px 4px 1px #444;
            position: absolute;
            top: 10%;
            /*left: 25%;*/
          }
      .btn-start {
        width: 40%;
        height: 40%;
        margin: -20% 0 0 -20%;
        border-radius: 50%;
        background: url('./start.png') #C94914 no-repeat;
        background-size: 100% 100%;
        position: absolute;
        top: 50%;
        left: 50%;
        z-index: 99;
        }
        .btn-start:before {
          content: "";
          display: block;
          width: 0rem;
          height: 0rem;
          border: .5rem solid #C94914;
          border-left-color: transparent;
          border-right-color: transparent;
          border-top-color: transparent;
          border-bottom-width: 3rem;
          margin: auto;
          margin-top: -3rem;
          position: relative;
        }
      .tips {
        margin-top: 1rem;
        }
        .tips .cube {
          display: block;
          float: left;
          width: 1rem;
          height: .4rem;
          line-height: 2.2rem;
          text-align: center;
          color: white;
          text-shadow: 0px 2px 2px #666;
        }
        .tips .cube.atari {
          outline: 10px solid red;
          z-index: 99;
          position: relative;
        }
  </style>

  <script>
    this.disabled = false

    let tweenable = new Tweenable()

    let initpies = ()=> {
      let pies
      let total
      if (!this.pies) {
        total = opts.total || 6
        pies = fill(Array(total), 0).map(function(a, i) {
          return {
            id: i+1,
            z: total - i,
            color: randomColor(),
          }
        })
      }
      else {
        pies = this.pies
        total = pies.length
      }
      pies = pies.map(function(pie, i) {
        let rot = (360 / total) >> 0
        let start = i * rot - rot / 2
        let end = (i != total - 1) ? start + rot : 360 - rot / 2
        return assign(pie, {
          start: start,
          end: end,
          angle: start + random(end - start),
        })
      })
      this.update({ pies })
      this.wheelpies.style.transform = ''
      this.wheelpies.style.webkitTransform = ''
    }

    let output = (msg, color)=> {
      let output = this.parent.output
      if (output) {
        this.parent.output.style.color = color
        this.parent.output.innerHTML = msg
      }
    }

    this.on('mount', ()=> {
      initpies()
    })

    this.start = ()=> {
      if (this.disabled) return

      initpies()
      let pie = sample(this.pies)
      let atari = pie.id

      tweenable.tween({
        from: { angle: 0 },
        to: { angle: 360 * 12 - pie.angle },
        duration: 10000,
        easing: 'easeOutQuart',
        step: (state) => { 
          this.wheelpies.style.transform = `rotate(${ state.angle }deg)`
          this.wheelpies.style.webkitTransform = `rotate(${ state.angle }deg)`
        },
        start: ()=> {
          this.update({ 
            disabled: true, 
            atari: null,
          })
        },
        finish: ()=> {
          output(atari, pie.color)
          this.update({ atari })

          if (this.pies.length == 2) {
            this.update({ disabled: true })
            /*setTimeout(()=> {
              output('结束')
            }, 3000)*/
          }
          else {
            this.update({ disabled: false })
            this.pies = reject(this.pies, (p)=> { return p == pie })
          }
        }
      })
    }
</script>
</bonuswheel>
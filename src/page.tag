import ua from './ua'
import './bonuswheel.tag'

<page>
  <div class="wrap">
    <div class="wheelWrap center">
      <bonuswheel class="wheel" total={{total}}/>
    </div>

    <!-- <div class="outputWarp" style="height: {{ stage.height - 800}}px">
      <div name="output">开始</div>
    </div> -->
  </div>
  
  <style scoped>
    :scope {
      height: 100%;
      background: #222 linear-gradient(top, #4f4f4f, #000000);
      background: #222 -webkit-linear-gradient(top, #4f4f4f, #000000);
      }
      :scope .wrap {
        margin: auto;
        width: 800px;
        /*height: 100%;
        overflow: hidden;
        overflow-y: auto;*/
      }

    .wheelWrap, 
    .outputWarp {
      display: flex;
      flex-flow: row wrap;
      align-items: center;
      justify-content: center; 
      text-align: justify;
      } 

    .wheelWrap {
      width: 800px;
      height: 800px;
      position: relative;
      }
      /*.wheelWrap:after {
        content: "";
        display: block;
        width: 150%;
        height: 150%;
        margin: -75% 0 0 -75%;
        position: absolute;
        top: 50%;
        left: 50%;
        z-index: 0;
        opacity: .5;
        background: url('../img/bg.png') no-repeat center;
        background-size: cover;
        animation-name: rotate;
        animation-duration: 50s;
        animation-iteration-count: infinite;
        animation-timing-function: linear;
        }
        @keyframes rotate {
          from { transform: rotate(0deg); }
          to { transform: rotate(-360deg); }
          }*/
      bonuswheel {
        position: relative;
        z-index: 1;
      }

    .outputWarp {
      font-size: 8rem;
      font-weight: 800;
      color: #eee;
      text-shadow: -1px 5px 2px gray;
      /*background: #002141;*/
      } 

  </style>

  <script>
    this.on('mount', ()=> {
      let stage = {
        width:  window.innerWidth || 
                document.documentElement.clientWidth || 
                document.body.clientWidth,
        height: document.body.clientHeight || 
                window.innerHeight || 
                document.documentElement.clientHeight,
      }
      this.update({ stage })

      ua({ pc: ()=> {
        let wrap = this.root.children[0]
        wrap.style.transform = `scale(.8)`
        wrap.style.webkitTransform = `scale(.8)`
        wrap.style.transformOrigin = `top center`
        wrap.style.webkitTransformOrigin = `top center`
      }})

      let input = prompt("请输入抽奖人数", '')
      this.update({ total: parseInt(input, 10) })


    })
    
</script>
</page>
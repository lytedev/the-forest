import Vue from 'vue'
import templateRender from './App.pug'
import Styles from './App.stylus'
import CooldownCircle from './CooldownCircle.vue'

App =
  components:
    CooldownCircle: CooldownCircle
  template: templateRender()
  data: ->
    plantingTime: 0
    lastUpdate: 0
    trees: 0
    saplings: 0
    seedlings: 0
    seeds: 5
    soilSize: 2

  computed:
    canPlant: ->
      @seeds > 0 and @plantingTime <= 0

    arcAngle: ->
      Math.PI * (this.lastUpdate % 1)

    seedlingCountdown: ->
      if @seedlings.length < 1 then return 0
      @seedlings[0][1] / @seedlings[0][0]

  methods:
    plantSeed: (n = 1) ->
      @plantingTime = PLANTING_TIME
      this.seeds -= n
      for i in [0..(n - 1)]
        this.seedlings.push [n, 0]
      console.log "Planting a seed..."

    getNumOf: (key) ->
      sum = 0
      for n in this[key]
        sum += n[0]
      return sum

    update: (elapsed) ->
      dt = (elapsed - this.lastUpdate) / 1000
      this.lastUpdate = elapsed

      if @plantingTime > 0
        @plantingTime -= dt

      for n of this.trees
        Vue.set this.trees[n], 1, parseFloat(this.trees[n][1]) + dt
        if this.trees[n][1] >= this.trees[n][0]


      for n of this.saplings
        Vue.set this.saplings[n], 1, parseFloat(this.saplings[n][1]) + dt

      for n of this.seedlings
        console.log n
        Vue.set this.seedlings[n], 1, parseFloat(this.seedlings[n][1]) + dt

      # console.log this.trees, this.saplings, this.seedlings

      requestAnimationFrame this.update

  mounted: ->
    requestAnimationFrame this.update

export default App

import templateRender from './App.pug'
import Styles from './App.stylus'
import CooldownCircle from './CooldownCircle.vue'

SEEDLING_GROW_TIME = 5
SAPLING_GROW_TIME = 60 * 5
TREE_DEATH_TIME = 60 * 60 * 5

App =
  components:
    CooldownCircle: CooldownCircle
  template: templateRender()
  data: ->
    lastUpdate: 0
    trees: []
    saplings: []
    seedlings: []
    seeds: 100

  computed:
    numTrees: ->
      this.getNumOf('trees')
    numSeedlings: ->
      this.getNumOf('seedlings')
    numTrees: ->
      this.getNumOf('saplings')

    arcAngle: ->
      Math.PI * (this.lastUpdate % 1)

  methods:
    plantSeed: (n = 1) ->
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

      for n in this.trees
        n[1] += dt

      for n in this.saplings
        n[1] += dt

      for n in this.seedlings
        n[1] += dt

      # console.log this.trees, this.saplings, this.seedlings

      requestAnimationFrame this.update

  mounted: ->
    requestAnimationFrame this.update

export default App

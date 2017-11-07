<template lang="pug">
  svg.cooldown-circle(width="100" height="100" viewBox="0 0 100 100")
    path(class="cooldown" fill="#ccc" stroke="none" v-bind:d="cooldownCirclePathDefinitionByPercent(percent)")
</template>

<script lang="coffee">
CooldownCircle =
  props:
    percent:
      type: Number
      default: 0.20

  data: ->
    ayy: 9

  methods:
    angleToRadians: (a) ->
      (a - 90) * Math.PI / 180

    polarToCartesian: (x, y, r, a) ->
      x: x + (r * Math.cos(a))
      y: y + (r * Math.sin(a))

    cooldownCirclePathDefinitionByPercent: (percent) ->
      percent = parseFloat(percent)
      if isNaN(percent) then percent = 0
      percent = percent % 1
      radius = 49
      start = { x: 50, y: 1 }
      offset = { x: 50, y: 50 }
      end = this.polarToCartesian offset.x, offset.y, radius, ((Math.PI * 2 * percent) - (Math.PI / 2))
      arcSweep = if percent < 0.5 then "1" else "0"

      [ 'M', start.x, start.y, 'A', radius, radius, 0, arcSweep, 0, end.x, end.y,
        'L', offset.x, offset.y, 'L', start.x, start.y,
      ].join(' ')


module.exports = CooldownCircle
</script>

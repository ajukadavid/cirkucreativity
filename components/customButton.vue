


<template>
  <div class="">
    <SilverMetallicButton 
      :size="size" 
      :state="state" 
      :disabled="disabled"
      @click="$emit('click', $event)"
    >
      {{ text }}
    </SilverMetallicButton>
  </div>
</template>

<script setup>
import SilverMetallicButton from './SilverMetallicButton.vue'

defineProps({
  text: {
    type: String,
    default: '',
  },
  size: {
    type: String,
    default: 'medium'
  },
  state: {
    type: String,
    default: 'default'
  },
  disabled: {
    type: Boolean,
    default: false
  }
})

defineEmits(['click'])
</script>





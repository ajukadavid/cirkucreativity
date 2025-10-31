<template>
  <div class="input-container">
    <input
      class="outline-none border-none bg-transparent text-center gradient-border"
      :placeholder="placeholder"
      v-model="inputValue"
    />
  </div>
</template>

<script setup>
const props = defineProps({
  placeholder: {
    type: String,
    default: 'Enter text here',
  },
});

const emit = defineEmits(['update:modelValue']);

const inputValue = ref('');

watch(inputValue, (newValue) => {
  emit('update:modelValue', newValue);
});
</script>

<style scoped>
.input-container {
  position: relative;
  display: inline-block;
  border-radius: 7px;
  padding: 2px; /* Space around the input for the gradient border */
}

.input-container::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  border-radius: 7px;
  padding: 2px; /* Width of the gradient border */
  background: linear-gradient(90deg, #D7D8D4 0%, #A8A9AD 50%, #8A8A8A 100%);
  -webkit-mask: 
    linear-gradient(#fff 0 0) content-box, 
    linear-gradient(#fff 0 0);
  -webkit-mask-composite: xor;
  mask-composite: exclude;
}

.gradient-border {
  position: relative;
  z-index: 1;
  border-radius: 7px;
  padding: 8px;
  width: 100%;
  background-color: transparent;
  color: inherit;
}
</style>

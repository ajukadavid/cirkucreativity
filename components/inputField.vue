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
  border-radius: 0;
  width: 100%;
}

.input-container::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  border: 2px solid #FFFFFF;
  border-radius: 0;
  pointer-events: none;
}

.gradient-border {
  position: relative;
  z-index: 1;
  border-radius: 0;
  padding: 12px 16px;
  width: 100%;
  background-color: transparent;
  color: #FFFFFF;
  border: none;
  outline: none;
}

.gradient-border::placeholder {
  color: rgba(255, 255, 255, 0.6);
}
</style>

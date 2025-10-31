<template>
  <button 
    :class="buttonClasses"
    @click="handleClick"
    :disabled="isDisabled"
    v-bind="$attrs"
  >
    <div class="silver-metallic-button__bevel">
      <div class="silver-metallic-button__inner">
        <svg 
          v-if="!iconOnly && !noicon" 
          class="silver-metallic-button__icon" 
          width="16" 
          height="16" 
          viewBox="0 0 16 16" 
          fill="none"
        >
          <path d="M8 1L10.5 6H15L11 9.5L12.5 15L8 11.5L3.5 15L5 9.5L1 6H5.5L8 1Z" fill="currentColor"/>
        </svg>
        <span v-if="!iconOnly" class="silver-metallic-button__text">
          <slot />
        </span>
        <svg 
          v-if="iconOnly" 
          class="silver-metallic-button__icon" 
          width="16" 
          height="16" 
          viewBox="0 0 16 16" 
          fill="none"
        >
          <path d="M8 1L10.5 6H15L11 9.5L12.5 15L8 11.5L3.5 15L5 9.5L1 6H5.5L8 1Z" fill="currentColor"/>
        </svg>
      </div>
    </div>
  </button>
</template>

<script setup>
import { computed } from 'vue'

// Define props with TypeScript-style interface
const props = defineProps({
  size: {
    type: String,
    default: 'medium',
    validator: (value) => ['small', 'medium', 'large'].includes(value)
  },
  state: {
    type: String,
    default: 'default',
    validator: (value) => ['default', 'hover', 'focused', 'disabled'].includes(value)
  },
  iconOnly: {
    type: Boolean,
    default: false
  },
  noicon: {
    type: Boolean,
    default: true
  },
  disabled: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['click'])

// Computed properties
const isDisabled = computed(() => props.state === 'disabled' || props.disabled)

const buttonClasses = computed(() => {
  const classes = [
    'silver-metallic-button',
    `silver-metallic-button--${props.size}`,
    `silver-metallic-button--${props.state}`,
    props.iconOnly && 'silver-metallic-button--icon-only'
  ].filter(Boolean)
  
  return classes.join(' ')
})

// Methods
const handleClick = (event) => {
  if (isDisabled.value) {
    event.preventDefault()
    return
  }
  emit('click', event)
}
</script>

<style scoped>
.silver-metallic-button {
  position: relative;
  border: none;
  cursor: pointer;
  font-family: 'DM Sans', sans-serif;
  font-weight: 600;
  font-size: 16px;
  line-height: 24px;
  letter-spacing: -0.16px;
  border-radius: 11px;
  transition: all 0.2s ease;
  background: linear-gradient(180deg, #D1D5DB 0%, #9CA3AF 100%);
  box-shadow: 0px 6px 12px rgba(55, 65, 81, 0.08);
}

.silver-metallic-button:focus {
  outline: none;
}

.silver-metallic-button__bevel {
  position: relative;
  border-radius: 10px;
  background: linear-gradient(180deg, #EEEFF2 0%, #9CA3AF 84.04%, #EEEFF2 100%);
  transition: all 0.2s ease;
}

.silver-metallic-button__inner {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 4px;
  border-radius: 8px;
  background: linear-gradient(0deg, #FFFFFF 0%, #E5E7EB 100%);
  color: #1F2937;
  text-shadow: -0.5px 0.5px 1px rgba(3, 7, 18, 0.12);
  transition: all 0.2s ease;
}

.silver-metallic-button__text {
  background: linear-gradient(135deg, #1F2937 29.17%, #6B7280 85.42%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: -0.5px 0.5px 1px rgba(3, 7, 18, 0.12);
}

.silver-metallic-button__icon {
  color: #1F2937;
  flex-shrink: 0;
}

/* Size variants */
.silver-metallic-button--large {
  height: 58px;
  padding: 2px;
}

.silver-metallic-button--large .silver-metallic-button__bevel {
  padding: 3px;
  height: 54px;
}

.silver-metallic-button--large .silver-metallic-button__inner {
  padding: 6px 12px;
  height: 48px;
}

.silver-metallic-button--medium {
  height: 48px;
  padding: 1px;
}

.silver-metallic-button--medium .silver-metallic-button__bevel {
  padding: 2px;
  height: 46px;
}

.silver-metallic-button--medium .silver-metallic-button__inner {
  padding: 6px 8px;
  height: 42px;
}

.silver-metallic-button--small {
  height: 40px;
  padding: 1px;
}

.silver-metallic-button--small .silver-metallic-button__bevel {
  padding: 2px;
  height: 38px;
}

.silver-metallic-button--small .silver-metallic-button__inner {
  padding: 6px;
  gap: 2px;
  height: 34px;
}

/* Icon only variants */
.silver-metallic-button--icon-only.silver-metallic-button--large {
  width: 58px;
}

.silver-metallic-button--icon-only.silver-metallic-button--medium {
  width: 48px;
}

.silver-metallic-button--icon-only.silver-metallic-button--small {
  width: 40px;
}

/* State variants */
.silver-metallic-button--hover:hover:not(:disabled),
.silver-metallic-button--hover {
  box-shadow: 0px 6px 12px rgba(55, 65, 81, 0.08);
}

.silver-metallic-button--hover:hover:not(:disabled) .silver-metallic-button__bevel,
.silver-metallic-button--hover .silver-metallic-button__bevel {
  background: linear-gradient(180deg, #EEEFF2 0%, #9CA3AF 84.04%, #EEEFF2 100%);
}

.silver-metallic-button--hover:hover:not(:disabled) .silver-metallic-button__inner,
.silver-metallic-button--hover .silver-metallic-button__inner {
  background: linear-gradient(0deg, #FFFFFF 0%, #E5E7EB 100%);
}

.silver-metallic-button--focused,
.silver-metallic-button:focus-visible {
  background: linear-gradient(180deg, #D1D5DB 0%, #9CA3AF 100%);
}

.silver-metallic-button--focused .silver-metallic-button__bevel,
.silver-metallic-button:focus-visible .silver-metallic-button__bevel {
  background: linear-gradient(180deg, #79DCA8 0%, #0E5738 50%, #79DCA8 100%);
}

.silver-metallic-button--focused .silver-metallic-button__inner,
.silver-metallic-button:focus-visible .silver-metallic-button__inner {
  background: linear-gradient(0deg, #FFFFFF 0%, #E5E7EB 100%);
}

.silver-metallic-button--disabled,
.silver-metallic-button:disabled {
  cursor: not-allowed;
  background: #6B7280;
  box-shadow: none;
}

.silver-metallic-button--disabled .silver-metallic-button__bevel,
.silver-metallic-button:disabled .silver-metallic-button__bevel {
  background: #6B7280;
}

.silver-metallic-button--disabled .silver-metallic-button__inner,
.silver-metallic-button:disabled .silver-metallic-button__inner {
  background: #6B7280;
  color: #D1D5DB;
}

.silver-metallic-button--disabled .silver-metallic-button__text,
.silver-metallic-button:disabled .silver-metallic-button__text {
  background: #D1D5DB;
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: none;
}

.silver-metallic-button--disabled .silver-metallic-button__icon,
.silver-metallic-button:disabled .silver-metallic-button__icon {
  color: #D1D5DB;
}

/* Active state */
.silver-metallic-button:active:not(:disabled) {
  transform: translateY(1px);
}

.silver-metallic-button:active:not(:disabled) .silver-metallic-button__inner {
  background: linear-gradient(180deg, #E5E7EB 0%, #FFFFFF 100%);
}
</style>



<script setup lang="ts">
import { Application } from '@splinetool/runtime';
import { onMounted, ref } from 'vue';

const canvas = ref<HTMLCanvasElement | null>(null);

onMounted(() => {
  if (canvas.value) {
    const spline = new Application(canvas.value);
    spline.load('https://prod.spline.design/mVBqluN2Q8pwCS-C/scene.splinecode');
    
  }
});
</script>

<template>
    <div class="text-white h-screen bg-black ">
        <div  class="flex justify-between items-center p-5 sticky top-0">
            <img @click="$router.push('/')" src="/images/inr.png" class="w-8" />
            <CustomButton @click="$router.push('/about')" text="Tap In" />
        </div>
        <div class="flex flex-col ">
          <img src="/images/bizzy.jpeg" class="w-full md:w-1/2 md:mx-auto  h-full px-5 my-5" />
            <!-- <canvas ref="canvas" id="canvas3d" class="relative"></canvas> -->
            <slot class="w-full max-w-md" />
        </div>
      
    
    </div>
</template>

<style scoped>
#canvas3d {
  width: 100%;
  height: 100%;
}
</style>


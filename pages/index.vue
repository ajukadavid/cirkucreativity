<script setup>
</script>
<template>
  <main class="main w-screen h-screen  flex flex-col justify-center items-center">
    
        <div class="title items-center justify-center uppercase space-y-2 md:space-y-4 mb-4 flex flex-col text-center text-2xl md:text-3xl lg:text-4xl px-4">
        <span class="text-5xl md:text-8xl mt-4">CIRku</span>
       
    </div>      
    <div class="title uppercase space-y-2 md:space-y-4 mb-4 flex flex-col text-center text-2xl md:text-3xl lg:text-4xl px-4">
        <span class="text-lg md:text-xl lg:text-2xl mt-4">Your Circle of creation</span>
        <span class="text-sm md:text-base mt-2">DIY Creative Experience</span>
    </div>
    <div class="w-full justify-center flex max-w-sm md:max-w-md px-4">
        <CtaBtn @click="$router.push('/collect')" class="mt-10" text="Reserve Your Spot"/>
    </div>
    <a 
      href="https://wa.me/+2349036322816?text=Hello!%20I%20would%20like%20to%20make%20a%20reservation%20for%20Cirku%20Creative%20Experience." 
      target="_blank" 
      rel="noopener noreferrer"
      class="text-center font-bold my-5 text-sm md:text-base px-4 block transition-colors"
    >
      Contact <span>09036322816</span>  <br />For Reservations.
    </a>

<footer class="text-center bg-transparent    mt-5">
            <span class="text-xs text-center footer-font">Circle Ent. {{ new Date().getFullYear() }}</span>
        </footer>
    </main>
 
</template>

<style scoped>






</style>
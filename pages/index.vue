<script setup>



const showModal =  ref(false)
const router = useRouter()

const handleShowModal = () => {
    showModal.value = true
}
</script>
<template>
  <main class="main w-screen h-screen  flex flex-col justify-center items-center">
    
        <div class="title bg-gradient-to-r flex items-center justify-center uppercase space-y-2 md:space-y-4 from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-2xl md:text-3xl lg:text-4xl px-4">
            <img src="/images/klr.png" class="w-16 md:w-20 mb-6 md:mb-10 max-w-full h-auto" alt="Cirku Logo" />
        <span class="text-5xl md:text-6xl mt-4">MAVO</span>
       
    </div>      
    <div class="title bg-gradient-to-r uppercase space-y-2 md:space-y-4 from-[#e2dfdf] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-2xl md:text-3xl lg:text-4xl px-4">
        <span class="text-sm md:text-base mt-4">Presents</span>
        <span>Kilometer II</span>
        <span class="text-lg md:text-xl lg:text-2xl">The Club experience</span>
        <span class="text-sm md:text-base mt-4">Release Party</span>
    </div>
    <div class="w-full justify-center flex max-w-sm md:max-w-md px-4">
        <CtaBtn @click="handleShowModal" class="mt-10" text="Get Exclusive Access"/>
    </div>
    <a 
      href="https://wa.me/+2349036322816?text=Hello!%20I%20would%20like%20to%20make%20a%20reservation%20for%20Kilometer%20II%20Release%20Party." 
      target="_blank" 
      rel="noopener noreferrer"
      class="text-center text-[#89898B] font-bold my-5 text-sm md:text-base px-4 block hover:text-[#fbf651] transition-colors"
    >
      Contact <span class="text-white">09036322816</span>  <br />For Reservations.
    </a>
    <CustomModal :isVisible="showModal" @update:isVisible="showModal = $event">

<div class="flex flex-col items-center justify-center  w-full">
    <img src="/images/inr.png" class="w-16 md:w-20 mb-6 md:mb-10 max-w-full h-auto" alt="Cirku Logo" />
    <div class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-xl md:text-2xl px-4">
        <span>Are you 18</span>
        <span>or older?</span>
    </div>
    <span class="text-center text-[#9F9F9F] mb-4 text-sm md:text-base px-4">Just making sure you’re <br /> old enough to drink liquor </span>
    <div class=" max-w-xs md:max-w-sm px-4">
        <CtaBtn @click="$router.push('/collect')" class="" text="Yes, I'm 18+" />
    </div>
    <span @click="$router.push('/negative')" class="footer text-[#89898B] text-xs md:text-sm mt-4 cursor-pointer hover:text-[#9F9F9F] transition-colors">No, I'm younger</span>
</div>
</CustomModal>

<footer class="text-center bg-transparent    mt-5">
            <span class="text-xs text-center  footer-font text-[#c0c0c0]">Circle Ent. {{ new Date().getFullYear() }}</span>
        </footer>
    </main>
 
</template>

<style scoped>






</style>
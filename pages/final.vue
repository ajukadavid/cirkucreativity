<script>
definePageMeta({
    layout: 'step'
})
</script>

<template>
     
    <div class="main w-screen h-fit  flex flex-col justify-center items-center ">
        <div>
          <div
            class="title bg-gradient-to-r from-[#FFFFFF] to-[#4C4B4B] mt-5 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
            <span>You’re all <br /> Set!</span>
        </div>
        <div class="text-center text-[#89898B] my-5">
            <span>
                We’ll contact you by email if you’re invited.
            </span>
        </div>
        <div class="px-32">
            <CustomButton @click="$router.push('/')" text="Home" />
        </div>     
        </div>
     
        <footer class="text-center bg-transparent left-36 mt-20 ">
            <span class="text-xs text-center  footer-font text-[#d1cfd8]">Circle Ent. 2025</span>
        </footer>
    </div>
</template>

<style scoped>
.main {

    background-image: url('../public/images/sky_bg.png');
background-size: cover;
background-repeat: no-repeat;
background-position:center;
}
</style>
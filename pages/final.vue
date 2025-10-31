<script>
definePageMeta({
    layout: 'step'
})
</script>

<template>
     
    <div class="main w-screen h-fit  flex flex-col justify-center items-center ">
        <div>
          <div
            class="title mt-5 flex flex-col text-center text-3xl ">
            <span>You're all <br /> Set!</span>
        </div>
        <div class="text-center my-5">
            <span>
                We'll contact you by email to confirm your reservation.
            </span>
        </div>
        <div class="px-32">
            <CustomButton @click="$router.push('/')" text="Home" />
        </div>     
        </div>
     
        <footer class="text-center bg-transparent left-36 mt-20 ">
            <span class="text-xs text-center footer-font">Circle Ent. 2025</span>
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
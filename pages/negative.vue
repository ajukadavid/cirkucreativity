<script setup>
definePageMeta({
    layout: 'step'
})
</script>

<template>
    <div class="flex flex-col items-center justify-center  space-y-4">
        <img src="/images/star1.png" />
        <span class="text-[#89898B] text-sm footer-font">OOPS!</span>

        <div
            class="title bg-gradient-to-r mt-4 from-[#FFFFFF] to-[#4C4B4B] mb-4 flex flex-col text-center text-transparent bg-clip-text text-3xl ">
            <span>Sorry, this event
                might not be
                for you! </span>
        </div>
        <CustomButton @click="$router.push('/')" text="Home" />
       <img src="/images/bottom.png" class="h-40 w-full mb-5"/>
    </div>
</template>

<style scoped>
.bottom {
    background-image: url('/public/images/bottom.png');
}
</style>


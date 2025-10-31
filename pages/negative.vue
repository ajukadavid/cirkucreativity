<script setup>
definePageMeta({
    layout: 'step'
})
</script>

<template>
    <div class="flex flex-col items-center justify-center  space-y-4">
        <img src="/images/star1.png" />
        <span class="text-sm footer-font">OOPS!</span>

        <div
            class="title mt-4 mb-4 flex flex-col text-center text-3xl ">
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


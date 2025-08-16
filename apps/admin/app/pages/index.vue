<template>
  <div class="flex flex-col items-center justify-center gap-4 h-screen">
    <h1 class="font-bold text-2xl text-(--ui-primary)">TT Panel - Admin</h1>

    <div class="flex items-center gap-2">
      <UButton
        label="Tasarım Teknesi"
        icon="i-lucide-square-play"
        to="https://www.tasarimteknesi.com"
        target="_blank"
      />

      <UButton
        label="GitHub"
        color="neutral"
        variant="outline"
        icon="i-simple-icons-github"
        to="https://github.com/bilalkaracomtr/ttpanel"
        target="_blank"
      />
    </div>
  </div>
</template>

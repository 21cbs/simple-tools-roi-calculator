<template>
  <div id="main" class="flex h-full min-h-screen w-full flex-col bg-dark-blue-gradient font-rubik">
    <main class="flex-grow">
      <div class="sm:mt24 mt-16 flex flex-col items-center justify-center px-4 text-white">
        <div class="flex w-full max-w-7xl flex-col items-center justify-center">
          <div class="flex flex-col items-center justify-center">
            <div class="flex w-full flex-col items-center justify-center space-y-2">
              <h1 class="flex flex-row items-center justify-center space-x-2 text-center text-3xl font-bold text-white">
                <span class="text-white">Keywords ROI Calculator </span>
              </h1>
              <h2 data-screenshot="false" class="pb-10 text-center font-normal text-white sm:pb-16 sm:text-lg">Import
                Semrush Excel to Generate Keywords ROI Table.</h2>
            </div>

            <div class="w-[900px] p-8 rounded-xl gap-6 bg-white flex flex-col items-center justify-center">
            <span class="text-black text-center">Keywords ROI Calculator </span>
            <span class="pb-10 text-center font-normal text-black sm:pb-16 sm:text-sm">Import Semrush Excel to Generate
              Keywords ROI Table.</span>
              <button
  class="mb-5 flex w-full min-w-max flex-row items-center justify-center space-x-2 rounded-2xl bg-button py-2 px-5 text-base font-medium text-white shadow-button-primary transition-all duration-100 hover:bg-orangeHover active:bg-orange sm:w-fit disabled:opacity-50 disabled:cursor-not-allowed"
  :disabled="btnDisabled" @click="triggerFileInput">Import Semrush Excel &nbsp; &nbsp;</button>

              <span class="font-normal text-black sm:text-sm">* The content uploaded is processed solely on your local device.</span>

            <input ref="fileInput" type="file" class="hidden" @change="handleFileUpload" />

            <BaseTable ref="baseTable" />
          </div>

          </div>



        </div>
      </div>
    </main>
  </div>
</template>

<script>
import * as XLSX from 'xlsx'

export default {
  data() {
    return {
      btnDisabled: false
    }
  },

  methods: {
    triggerFileInput() {
      this.$refs.fileInput.click()
    },

    handleFileUpload(event) {
      const file = event.target.files[0]

      if (file) {
        this.btnDisabled = true

        const reader = new FileReader()
        reader.onload = (e) => {
          const data = e.target.result
          const workbook = XLSX.read(data, { type: 'binary' })
          const sheetName = workbook.SheetNames[0]
          const sheet = workbook.Sheets[sheetName]
          const jsonData = XLSX.utils.sheet_to_json(sheet)

          this.$refs.baseTable.processData(jsonData)

          this.btnDisabled = false
        }

        reader.readAsBinaryString(file)
      }
    }
  }
}
</script>

import moment from "moment"
import axios from "axios"

export default {
    name: "test-table",
    watch: {
        pagination: {
            async handler() {
                const rowsPerPage = this.pagination.rowsPerPage
                // const skip = (this.pagination.page - 1) * rowsPerPage
                const pageNumber = this.pagination.page
                const res = await axios.get(`https://reqres.in/api/users?page=${pageNumber}&per_page=${rowsPerPage}`)
                this.items = res.data.data
                this.$store.commit("saveTableData", this.items)
            },
            deep: true
        }
    },
    computed: {
        pages() {
            return 171
        },
        totalItemCount() {
            return 400
        }
    },
    async mounted() {
        const rowsPerPage = this.pagination.rowsPerPage
        const skip = (this.pagination.page - 1) * rowsPerPage
        const res = await axios.get(`https://reqres.in/api/users?page=${skip}&per_page=${rowsPerPage}`)
        this.items = res.data.data
        this.$store.commit("saveTableData", this.items)
    },
    methods: {
        nzDate: function (dt) {
            return moment(dt).format("DD/MM/YYYY")
        }
    },
    data: () => ({
        search: "",
        // totalItems: 0,
        items: [],
        pagination: {
            sortBy: "Date"
        },
        headers: [
            { text: "ID", value: "id" },
            { text: "First Name", value: "first_name" },
            { text: "Last Name", value: "last_name" },
            { text: "Avatar", value: "avatar" }
        ]
    })
}
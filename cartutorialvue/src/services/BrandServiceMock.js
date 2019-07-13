import Vue from 'vue';

Vue.mixin({
  beforeCreate() {
    const options = this.$options;
    if (options.brandSvc) {
      this.$brandSvc = options.brandSvc;
    } else if (options.parent && options.parent.$brandSvc) {
      this.$brandSvc = options.parent.$brandSvc;
    }
  },
});

class BrandServiceMock {
  getBrands() {
    return ['alfa romeo', 'fiat', 'peugeot', 'dacia', 'renault', 'ferrari'];
  }
}

export default function newBrandServiceMock() {
  return new BrandServiceMock();
}

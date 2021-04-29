import { expect } from 'chai';
import { shallowMount } from '@vue/test-utils';
import BrandList from '@/components/BrandList.vue';

describe('BrandList.vue', () => {
  it('renders props.msg when passed', () => {
    const msg = 'new message';
    const wrapper = shallowMount(BrandList, {
      propsData: { msg },
    });
    expect(wrapper.text()).to.include(msg);
  });
});

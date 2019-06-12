const BeerView = () => import('@/components/BeerView');
const SampleView = () => import('@/components/SampleView');
const TestView = () => import('@/components/testView');


const routes = [
    {
        path: '/',
        name: 'BeerView',
        component: BeerView
    },
    {
        path: '/sampleViewDatatable',
        name: 'sampleView',
        component: SampleView
    },
    {
        path:'/testView',
        name:'testView',
        component:TestView
    }
];

export default routes;

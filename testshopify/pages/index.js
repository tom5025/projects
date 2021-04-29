import { Layout, Page, TextStyle } from '@shopify/polaris';

const Index = () => (
  <Page
    primaryAction={{
      content: 'Select products',
    }}
  >
  <Layout>  
      <TextStyle variation="positive">
        Sample app using React and Next.js
      </TextStyle>
    </Layout>    
  </Page>
);

export default Index;
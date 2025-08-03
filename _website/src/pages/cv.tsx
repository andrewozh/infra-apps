import type {ReactNode} from 'react';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';

export default function CV(): ReactNode {
  return (
    <Layout
      title="CV - Andrew Ozhegov"
      description="Andrew Ozhegov's Curriculum Vitae">
      <div style={{
        maxWidth: '800px',
        margin: '2rem auto',
        padding: '0 2rem',
        lineHeight: '1.6'
      }}>
        <Heading as="h1" style={{
          textAlign: 'center',
          marginBottom: '2rem',
          color: 'var(--ifm-color-primary)'
        }}>
          Andrew Ozhegov
        </Heading>
        
        <div style={{
          textAlign: 'center',
          marginBottom: '3rem',
          fontSize: '1.2rem',
          color: 'var(--ifm-color-primary-dark)'
        }}>
          DevOps | Cloud | Platform Engineer
        </div>

        <section style={{ marginBottom: '2rem' }}>
          <Heading as="h2">Contact Information</Heading>
          <p>
            <strong>Email:</strong> andrewozhegov@gmail.com<br/>
            <strong>GitHub:</strong> <a href="https://github.com/andrewozh" target="_blank">github.com/andrewozh</a><br/>
            <strong>LinkedIn:</strong> <a href="https://linkedin.com/in/andrewozh" target="_blank">linkedin.com/in/andrewozh</a>
          </p>
        </section>

        <section style={{ marginBottom: '2rem' }}>
          <Heading as="h2">Professional Summary</Heading>
          <p>
            Experienced DevOps, Cloud, and Platform Engineer with expertise in modern infrastructure,
            automation, and cloud technologies. Passionate about building scalable, reliable systems
            and improving development workflows.
          </p>
        </section>

        <section style={{ marginBottom: '2rem' }}>
          <Heading as="h2">Technical Skills</Heading>
          <ul>
            <li><strong>Cloud Platforms:</strong> AWS, Azure, Google Cloud Platform</li>
            <li><strong>Infrastructure as Code:</strong> Terraform, CloudFormation, Pulumi</li>
            <li><strong>Container Technologies:</strong> Docker, Kubernetes, EKS, AKS, GKE</li>
            <li><strong>CI/CD:</strong> Jenkins, GitLab CI, GitHub Actions, Azure DevOps</li>
            <li><strong>Monitoring & Logging:</strong> Prometheus, Grafana, ELK Stack, DataDog</li>
            <li><strong>Configuration Management:</strong> Ansible, Chef, Puppet</li>
            <li><strong>Programming:</strong> Python, Bash, Go, JavaScript</li>
          </ul>
        </section>

        <section style={{ marginBottom: '2rem' }}>
          <Heading as="h2">Experience</Heading>
          <div style={{ marginBottom: '1.5rem' }}>
            <h3>Senior DevOps Engineer</h3>
            <p style={{ fontStyle: 'italic', marginBottom: '0.5rem' }}>Company Name • 2020 - Present</p>
            <ul>
              <li>Led infrastructure automation initiatives reducing deployment time by 70%</li>
              <li>Designed and implemented CI/CD pipelines for 50+ microservices</li>
              <li>Managed Kubernetes clusters serving 1M+ daily active users</li>
              <li>Implemented monitoring and alerting systems improving MTTR by 60%</li>
            </ul>
          </div>
          
          <div style={{ marginBottom: '1.5rem' }}>
            <h3>Cloud Platform Engineer</h3>
            <p style={{ fontStyle: 'italic', marginBottom: '0.5rem' }}>Previous Company • 2018 - 2020</p>
            <ul>
              <li>Migrated legacy applications to cloud-native architecture</li>
              <li>Built self-service platform reducing developer onboarding time by 80%</li>
              <li>Implemented Infrastructure as Code practices across the organization</li>
            </ul>
          </div>
        </section>

        <section style={{ marginBottom: '2rem' }}>
          <Heading as="h2">Education</Heading>
          <p>
            <strong>Bachelor's Degree in Computer Science</strong><br/>
            University Name • Year
          </p>
        </section>

        <section style={{ marginBottom: '2rem' }}>
          <Heading as="h2">Certifications</Heading>
          <ul>
            <li>AWS Certified Solutions Architect</li>
            <li>Certified Kubernetes Administrator (CKA)</li>
            <li>HashiCorp Certified: Terraform Associate</li>
          </ul>
        </section>
      </div>
    </Layout>
  );
}

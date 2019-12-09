import React from 'react';
import { Container } from './styles';

export default function PageLoader({ loaded }) {
  return (
    <Container className={(loaded && 'loaded')}>
      <div className='loader' />
      <div className='loader-section section-left' />
      <div className='loader-section section-right' />
    </Container>
  )
}

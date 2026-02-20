import './index.css'
import TerminalSystem from './Terminal'
import collage1 from './assets/collage_1.jpg'
import collage2 from './assets/collage_2.jpg'
import collage3 from './assets/collage_3.jpg'
import collage4 from './assets/collage_4.jpg'

function App() {
  return (
    <div className="terminal-frame">
      <div className="terminal-header">
        <div>
          <span className="barcode"></span>
        </div>
      </div>

      <div className="occult-container">
        {/* Organic Art Layer 1 - Prominent Hand/Eye */}
        <div className="symbol-wrapper" style={{ alignSelf: 'flex-start', marginLeft: '5%', maxWidth: '900px' }}>
          <img src={collage1} alt="Art Layer 1" className="stippled-image prominent" />
        </div>

        {/* Organic Art Layer 2 - Lunar Landscape */}
        <div className="symbol-wrapper" style={{ alignSelf: 'flex-end', marginRight: '5%', marginTop: '-15rem', maxWidth: '1000px' }}>
          <img src={collage2} alt="Art Layer 2" className="stippled-image prominent" />
        </div>

        {/* Organic Art Layer 3 - Veiled Figure */}
        <div className="symbol-wrapper" style={{ alignSelf: 'flex-start', marginLeft: '10%', marginTop: '-10rem', maxWidth: '850px' }}>
          <img src={collage3} alt="Art Layer 3" className="stippled-image prominent" />
        </div>

        {/* Organic Art Layer 4 - Slashed Face/Triangle */}
        <div className="symbol-wrapper" style={{ alignSelf: 'center', marginTop: '-5rem', maxWidth: '1100px' }}>
          <img src={collage4} alt="Art Layer 4" className="stippled-image prominent" />
        </div>
      </div>

      <TerminalSystem />
    </div>
  )
}

export default App

import './index.css'
import occultHand from './assets/occult_hand_1771617146959.png'
import occultFace from './assets/occult_face_1771617162050.png'
import occultSnakes from './assets/occult_snakes_1771617176270.png'

const SriYantraSvg = () => (
  <div className="svg-container">
    <svg className="sri-yantra" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      {/* Outer circles */}
      <circle cx="50" cy="50" r="48" />
      <circle cx="50" cy="50" r="42" />

      {/* Upward geometric triangles */}
      <polygon points="50,15 85,75 15,75" />
      <polygon points="50,25 75,70 25,70" />
      <polygon points="50,35 65,65 35,65" />

      {/* Downward geometric triangles */}
      <polygon points="15,25 85,25 50,85" />
      <polygon points="25,35 75,35 50,75" />
      <polygon points="35,45 65,45 50,65" />

      {/* Horizontal intersecting lines */}
      <line x1="20" y1="50" x2="80" y2="50" />
      <line x1="28" y1="40" x2="72" y2="40" />

      {/* Small central components */}
      <circle cx="50" cy="50" r="3" fill="#b93f3f" opacity="0.8" />
    </svg>
  </div>
);

function App() {
  return (
    <div className="occult-container">

      {/* 1. Occult Hand */}
      <div className="symbol-wrapper">
        <img src={occultHand} alt="Occult Hand with Eye" className="stippled-image" />
      </div>

      {/* 2. Occult Face with Accents */}
      <div className="symbol-wrapper">
        <div className="face-accent left">
          <div className="eye-icon"></div>
          <div className="eye-accent-line right"></div>
        </div>

        <img src={occultFace} alt="Veiled Face" className="stippled-image" />

        <div className="face-accent right">
          <div className="eye-accent-line left"></div>
          <div className="eye-icon"></div>
        </div>
      </div>

      {/* 3. Red Geometric Pyramid (Sri Yantra) */}
      <div className="symbol-wrapper">
        <SriYantraSvg />
      </div>

      {/* 4. Intertwined Snakes */}
      <div className="symbol-wrapper" style={{ animationDelay: "2s" }}>
        <img src={occultSnakes} alt="Two-Headed Snakes" className="stippled-image" style={{ maxHeight: "150px" }} />
      </div>

    </div>
  )
}

export default App

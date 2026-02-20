import React from 'react';
import './GoeticCircle.css';
import overlayImg from './assets/goetic_overlay.png';
import staticBg from './assets/static_bg.mp4';

const GoeticCircle = () => {
    return (
        <div className="goetic-image-container">
            {/* Video Background Layer */}
            <video
                autoPlay
                muted
                loop
                playsInline
                className="goetic-video-bg"
            >
                <source src={staticBg} type="video/mp4" />
            </video>

            {/* Transparent PNG Overlay Layer */}
            <img src={overlayImg} alt="Goetic Circle Overlay" className="goetic-image-base" />

            {/* Interaction Layer */}
            <svg
                viewBox="0 0 1000 1350"
                xmlns="http://www.w3.org/2000/svg"
                className="goetic-hit-layer"
            >
                <defs>
                    <filter id="esoteric-glow">
                        <feGaussianBlur stdDeviation="4" result="blur" />
                        <feComposite in="SourceGraphic" in2="blur" operator="over" />
                    </filter>
                </defs>

                {/* Triangle Hotspot */}
                <g className="hit-area triangle-hit" transform="translate(500, 180)">
                    <polygon points="0,-160 210,160 -210,160" fill="transparent" />
                </g>

                {/* Main Circle Ring Hotspot */}
                <g className="hit-area circle-hit" transform="translate(500, 780)">
                    <circle cx="0" cy="0" r="360" fill="transparent" />
                    <circle cx="0" cy="0" r="280" fill="transparent" className="negative-hit" />
                </g>

                {/* Inner Stars Hotspots */}
                {[
                    { x: 500, y: 620 }, { x: 660, y: 780 },
                    { x: 500, y: 940 }, { x: 340, y: 780 }
                ].map((pos, i) => (
                    <circle key={i} cx={pos.x} cy={pos.y} r="60" className="hit-area star-hit" fill="transparent" />
                ))}

                {/* Center Seal Hotspot */}
                <g className="hit-area center-hit" transform="translate(500, 780) rotate(45)">
                    <rect x="-70" y="-70" width="140" height="140" fill="transparent" />
                </g>

                {/* Corner Stars */}
                {[
                    { x: 120, y: 550 }, { x: 880, y: 550 },
                    { x: 120, y: 1050 }, { x: 880, y: 1050 }
                ].map((pos, i) => (
                    <circle key={i} cx={pos.x} cy={pos.y} r="50" className="hit-area corner-hit" fill="transparent" />
                ))}
            </svg>
        </div>
    );
};

export default GoeticCircle;

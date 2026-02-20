import { useState, useTransition, Activity } from 'react';
import { motion } from 'motion/react';
import './terminal.css';

const TerminalTab1 = () => {
    const [lines, setLines] = useState(['_']);
    const [input, setInput] = useState('');
    const [isPending, startTransition] = useTransition();

    const handleKeyDown = (e) => {
        if (e.key === 'Enter' && input) {
            setLines([...lines, '> ' + input, '█']);
            setInput('');

            // Advanced Concurrency: Yielding aesthetic updates to keystrokes
            startTransition(() => {
                document.body.classList.add('glitch-heavy');
                setTimeout(() => {
                    startTransition(() => document.body.classList.remove('glitch-heavy'));
                }, 150);
            });
        }
    };

    const handleInputChange = (e) => {
        setInput(e.target.value);
    }

    return (
        <div className="terminal-content">
            {lines.map((line, i) => <div key={i} className="terminal-log">{line}</div>)}
            <div className="terminal-input-row">
                <span className="accent">&gt;</span>
                <input
                    type="text"
                    className="terminal-input"
                    value={input}
                    onChange={handleInputChange}
                    onKeyDown={handleKeyDown}
                    autoFocus
                    spellCheck={false}
                />
            </div>
            {isPending && <span style={{ position: 'absolute', right: 0, top: 0, color: 'var(--accent-color)', fontSize: '0.8rem' }}>...</span>}
        </div>
    );
};

const RitualTab = () => {
    const [cycle, setCycle] = useState(0);

    // This tab simulates a heavier background DOM process that maintains state
    return (
        <div className="terminal-content" style={{ textAlign: 'center', padding: '2rem' }}>
            <div style={{ marginTop: '2rem', display: 'flex', justifyContent: 'center', gap: '1rem' }}>
                <div className="barcode" style={{ animation: 'static-noise 0.5s infinite', margin: 0, opacity: 0.5 }}></div>
                <div className="barcode" style={{ animation: 'static-noise 0.7s infinite reverse', margin: 0, transform: 'scaleX(-1)' }}></div>
            </div>
            <button
                onClick={() => setCycle(c => c + 1)}
                style={{
                    marginTop: '2rem',
                    background: 'transparent',
                    border: '1px solid var(--accent-color)',
                    color: 'var(--accent-color)',
                    padding: '0.5rem 2rem',
                    cursor: 'pointer',
                    fontFamily: 'var(--font-mono)'
                }}
            >
                {cycle}
            </button>
        </div>
    );
};

export default function TerminalSystem() {
    const [activeTab, setActiveTab] = useState('console');

    // Brutalist physics config for Motion.dev
    // Infinite stiffness / Hard steps approximation
    const motionProps = {
        transition: { type: "spring", stiffness: 2000, damping: 10, mass: 0.1 }
    };

    return (
        <div style={{ marginTop: '2rem', flex: 1, display: 'flex', flexDirection: 'column' }}>
            <div className="terminal-tabs">
                <button className={`terminal-tab ${activeTab === 'console' ? 'active' : ''}`} onClick={() => setActiveTab('console')}>█</button>
                <button className={`terminal-tab ${activeTab === 'ritual' ? 'active' : ''}`} onClick={() => setActiveTab('ritual')}>▲</button>
            </div>

            <div className="terminal-viewport" style={{ position: 'relative', minHeight: '300px' }}>

                <Activity mode={activeTab === 'console' ? 'visible' : 'hidden'}>
                    <motion.div
                        initial={false}
                        animate={{
                            opacity: activeTab === 'console' ? 1 : 0,
                            display: activeTab === 'console' ? 'block' : 'none',
                            y: activeTab === 'console' ? 0 : 10
                        }}
                        {...motionProps}
                    >
                        <TerminalTab1 />
                    </motion.div>
                </Activity>

                <Activity mode={activeTab === 'ritual' ? 'visible' : 'hidden'}>
                    <motion.div
                        initial={false}
                        animate={{
                            opacity: activeTab === 'ritual' ? 1 : 0,
                            display: activeTab === 'ritual' ? 'block' : 'none',
                            scale: activeTab === 'ritual' ? 1 : 0.95
                        }}
                        {...motionProps}
                    >
                        <RitualTab />
                    </motion.div>
                </Activity>

            </div>
        </div>
    );
}

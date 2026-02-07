import { useState } from 'react'
import { useNavigate, Link } from 'react-router-dom'

// Demo credentials for testing
const VALID_CREDENTIALS = {
    email: 'test@legna.dev',
    password: 'EphemeralTest@2026'
}

function Login() {
    const navigate = useNavigate()
    const [formData, setFormData] = useState({ email: '', password: '' })
    const [errors, setErrors] = useState({})
    const [submitError, setSubmitError] = useState('')
    const [isLoading, setIsLoading] = useState(false)

    const validateEmail = (email) => {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
        return emailRegex.test(email)
    }

    const validateForm = () => {
        const newErrors = {}

        if (!formData.email.trim()) {
            newErrors.email = 'Email is required'
        } else if (!validateEmail(formData.email)) {
            newErrors.email = 'Please enter a valid email address'
        }

        if (!formData.password) {
            newErrors.password = 'Password is required'
        } else if (formData.password.length < 6) {
            newErrors.password = 'Password must be at least 6 characters'
        }

        setErrors(newErrors)
        return Object.keys(newErrors).length === 0
    }

    const handleChange = (e) => {
        const { name, value } = e.target
        setFormData(prev => ({ ...prev, [name]: value }))
        // Clear field error on change
        if (errors[name]) {
            setErrors(prev => ({ ...prev, [name]: '' }))
        }
        setSubmitError('')
    }

    const handleSubmit = async (e) => {
        e.preventDefault()
        setSubmitError('')

        if (!validateForm()) {
            return
        }

        setIsLoading(true)

        // Simulate API call delay
        await new Promise(resolve => setTimeout(resolve, 800))

        // Check credentials
        if (formData.email === VALID_CREDENTIALS.email &&
            formData.password === VALID_CREDENTIALS.password) {
            // Success - redirect to dashboard
            navigate('/dashboard', { state: { user: formData.email } })
        } else {
            setSubmitError('Invalid email or password. Please try again.')
        }

        setIsLoading(false)
    }

    return (
        <div className="page login-page" data-testid="login-page">
            <div className="login-container">
                <div className="login-header">
                    <Link to="/" className="back-link" data-testid="back-to-home">
                        ← Back to Home
                    </Link>
                    <h1 data-testid="login-title">Sign In</h1>
                    <p>Enter your credentials to access the dashboard</p>
                </div>

                <form onSubmit={handleSubmit} className="login-form" data-testid="login-form">
                    {submitError && (
                        <div className="error-banner" data-testid="submit-error" role="alert">
                            {submitError}
                        </div>
                    )}

                    <div className="form-group">
                        <label htmlFor="email">Email</label>
                        <input
                            type="text"
                            id="email"
                            name="email"
                            value={formData.email}
                            onChange={handleChange}
                            placeholder="Enter your email"
                            data-testid="email-input"
                            aria-invalid={!!errors.email}
                            aria-describedby={errors.email ? 'email-error' : undefined}
                        />
                        {errors.email && (
                            <span className="field-error" id="email-error" data-testid="email-error">
                                {errors.email}
                            </span>
                        )}
                    </div>

                    <div className="form-group">
                        <label htmlFor="password">Password</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            value={formData.password}
                            onChange={handleChange}
                            placeholder="Enter your password"
                            data-testid="password-input"
                            aria-invalid={!!errors.password}
                            aria-describedby={errors.password ? 'password-error' : undefined}
                        />
                        {errors.password && (
                            <span className="field-error" id="password-error" data-testid="password-error">
                                {errors.password}
                            </span>
                        )}
                    </div>

                    <button
                        type="submit"
                        className="submit-button"
                        data-testid="submit-button"
                        disabled={isLoading}
                    >
                        {isLoading ? 'Signing in...' : 'Sign In'}
                    </button>
                </form>

                <div className="demo-credentials" data-testid="demo-credentials">
                    <p><strong>Demo Credentials:</strong></p>
                    <p>Email: test@legna.dev</p>
                    <p>Password: EphemeralTest@2026</p>
                </div>
            </div>
        </div>
    )
}

export default Login

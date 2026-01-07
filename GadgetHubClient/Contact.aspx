<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="GadgetHubClient.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Contact Page Specific Styles */
        .contact-container {
            animation:fadeIn 0.6s ease;
        }

        /* Hero Section */
        .contact-hero {
            background:linear-gradient(135deg, rgba(22, 33, 62, 0.95), rgba(15, 52, 96, 0.95));
            backdrop-filter:blur(10px);
            border: 1px solid #2d3561;
            border-radius:16px;
            padding:50px 40px;
            margin-bottom:40px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
            text-align:center;
        }

        .contact-hero h2 {
            font-size:48px;
            background:linear-gradient(135deg, #e94560, #00d9ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            background-clip:text;
            margin-bottom:15px;
            font-weight:700;
        }

        .contact-hero p {
            font-size: 18px;
            color:#aaa;
            max-width:700px;
            margin:0 auto;
            line-height:1.8;
        }

        .hero-icon {
            font-size:80px;
            margin-bottom: 20px;
            display:inline-block;
            animation:float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform:translateY(-10px); }
        }

        /* Main Content Grid */
        .contact-grid {
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:30px;
            margin-bottom:40px;
        }

        /* Contact Form Card */
        .contact-form-card {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:16px;
            padding:40px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
            animation:slideInLeft 0.6s ease;
        }

        .contact-form-card h3 {
            color:#00d9ff;
            font-size:28px;
            margin-bottom:25px;
            font-weight: 600;
        }

        /* Form Styling */
        .form-group {
            margin-bottom:25px;
        }

        .form-group label {
            display:block;
            color:#aaa;
            font-size:14px;
            font-weight:600;
            margin-bottom:8px;
            text-transform:uppercase;
            letter-spacing:0.5px;
        }

        .form-group input,
        .form-group textarea {
            width:100%;
            background:#0f3460 !important;
            border:2px solid #2d3561 !important;
            color:#eee !important;
            padding:12px 15px;
            border-radius:8px;
            font-size: 15px;
            transition:all 0.3s ease;
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline:none;
            border-color:#00d9ff ! important;
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.5);
        }

        .form-group textarea {
            min-height:120px;
            resize:vertical;
        }

        .submit-btn {
            background:linear-gradient(135deg, #e94560, #d63350);
            color:white;
            border:none;
            padding:15px 40px;
            border-radius:8px;
            font-size:16px;
            font-weight: 600;
            text-transform:uppercase;
            letter-spacing:1px;
            cursor:pointer;
            transition:all 0.3s ease;
            width:100%;
            box-shadow:0 4px 15px rgba(233, 69, 96, 0.3);
        }

        .submit-btn:hover {
            transform:translateY(-3px);
            box-shadow:0 8px 25px rgba(233, 69, 96, 0.5);
            background:linear-gradient(135deg, #d63350, #e94560);
        }

        .submit-btn:active {
            transform:translateY(0);
        }

        /* Contact Info Card */
        .contact-info-card {
            background:rgba(22, 33, 62, 0.95);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:16px;
            padding:40px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.5);
            animation:slideInRight 0.6s ease;
        }

        .contact-info-card h3 {
            color:#00d9ff;
            font-size:28px;
            margin-bottom:30px;
            font-weight: 600;
        }

        /* Contact Methods */
        .contact-method {
            background:rgba(15, 52, 96, 0.6);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:25px;
            margin-bottom: 20px;
            transition:all 0.3s ease;
        }

        .contact-method:hover {
            transform:translateX(10px);
            border-color:#00d9ff;
            box-shadow:0 4px 20px rgba(0, 217, 255, 0.2);
        }

        .contact-method-icon {
            font-size: 32px;
            margin-bottom: 15px;
            display: block;
        }

        .contact-method h4 {
            color:#eee;
            font-size: 18px;
            margin-bottom:10px;
            font-weight:600;
        }

        .contact-method p {
            color:#aaa;
            margin: 5px 0;
            font-size:15px;
            line-height:1.6;
        }

        .contact-method a {
            color:#00d9ff;
            text-decoration:none;
            transition:all 0.3s ease;
        }

        .contact-method a:hover {
            color:#00ffff;
            text-shadow: 0 0 10px rgba(0, 217, 255, 0.5);
        }

        /* Office Locations */
        .locations-section {
            margin-top:40px;
        }

        .section-title {
            font-size:32px;
            color:#00d9ff;
            text-align:center;
            margin-bottom:40px;
            font-weight:600;
        }

        .locations-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(300px, 1fr));
            gap:30px;
        }

        .location-card {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:12px;
            padding:30px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
            transition:all 0.3s ease;
        }

        .location-card:hover {
            transform:translateY(-10px);
            border-color:#e94560;
            box-shadow:0 12px 40px rgba(233, 69, 96, 0.3);
        }

        .location-icon {
            font-size:48px;
            margin-bottom:20px;
        }

        .location-card h4 {
            color:#eee;
            font-size: 22px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .location-card p {
            color:#aaa;
            line-height:1.8;
            margin: 5px 0;
        }

        /* Social Media Section */
        .social-section {
            background:linear-gradient(135deg, rgba(233, 69, 96, 0.1), rgba(0, 217, 255, 0.1));
            border:1px solid #2d3561;
            border-radius: 16px;
            padding:40px;
            margin-top:40px;
            text-align:center;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .social-section h3 {
            color:#eee;
            font-size: 28px;
            margin-bottom:30px;
            font-weight: 600;
        }

        .social-links {
            display:flex;
            justify-content:center;
            gap:30px;
            flex-wrap: wrap;
        }

        .social-link {
            width:60px;
            height:60px;
            background:rgba(15, 52, 96, 0.8);
            border: 2px solid #2d3561;
            border-radius: 50%;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:28px;
            transition:all 0.3s ease;
            text-decoration:none;
        }

        .social-link:hover {
            transform:translateY(-5px) scale(1.1);
            border-color:#00d9ff;
            box-shadow:0 8px 20px rgba(0, 217, 255, 0.4);
        }

        /* FAQ Section */
        .faq-section {
            background:rgba(22, 33, 62, 0.9);
            backdrop-filter:blur(10px);
            border:1px solid #2d3561;
            border-radius:16px;
            padding:40px;
            margin-top:40px;
            box-shadow:0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .faq-item {
            margin-bottom:25px;
            padding-bottom:25px;
            border-bottom:1px solid rgba(45, 53, 97, 0.5);
        }

        .faq-item:last-child {
            border-bottom:none;
            margin-bottom:0;
            padding-bottom:0;
        }

        .faq-question {
            color:#00d9ff;
            font-size:18px;
            font-weight:600;
            margin-bottom:10px;
        }

        .faq-answer {
            color:#aaa;
            line-height:1.8;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity:0;
                transform: translateY(20px);
            }
            to {
                opacity:1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity:0;
                transform:translateX(-30px);
            }
            to {
                opacity:1;
                transform:translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity:0;
                transform:translateX(30px);
            }
            to {
                opacity:1;
                transform:translateX(0);
            }
        }

        /* Responsive */
        @media (max-width:968px) {
            .contact-grid {
                grid-template-columns:1fr;
            }

            .contact-hero {
                padding:30px 20px;
            }

            .contact-hero h2 {
                font-size:32px;
            }

            .locations-grid {
                grid-template-columns:1fr;
            }
        }
    </style>

    <main aria-labelledby="title" class="contact-container">
        <!-- Hero Section -->
        <section class="contact-hero">
            <div class="hero-icon">📞</div>
            <h2 id="title">Get In Touch</h2>
            <p>
                Have questions about our products or services? We'd love to hear from you. 
                Send us a message and we'll respond as soon as possible.
            </p>
        </section>

        <!-- Main Contact Grid -->
        <div class="contact-grid">
            <!-- Contact Form -->
            <div class="contact-form-card">
                <h3>📧 Send Us a Message</h3>
                <form>
                    <div class="form-group">
                        <label for="name">Your Name</label>
                        <input type="text" id="name" placeholder="John Doe" required />
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" placeholder="john@example.com" required />
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" placeholder="How can we help you?" required />
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" placeholder="Tell us more about your inquiry..." required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>

            <!-- Contact Information -->
            <div class="contact-info-card">
                <h3>📍 Contact Information</h3>
                
                <div class="contact-method">
                    <span class="contact-method-icon">📍</span>
                    <h4>Headquarters</h4>
                    <p>One Microsoft Way</p>
                    <p>Redmond, WA 98052-6399</p>
                    <p>United States</p>
                </div>

                <div class="contact-method">
                    <span class="contact-method-icon">📞</span>
                    <h4>Phone</h4>
                    <p><a href="tel:+14255550100">+1 (425) 555-0100</a></p>
                    <p>Mon-Fri:9:00 AM - 6:00 PM PST</p>
                </div>

                <div class="contact-method">
                    <span class="contact-method-icon">✉️</span>
                    <h4>Email</h4>
                    <p><strong>Support:</strong> <a href="mailto:support@gadgethub.com">support@gadgethub.com</a></p>
                    <p><strong>Sales:</strong> <a href="mailto:sales@gadgethub.com">sales@gadgethub.com</a></p>
                    <p><strong>Marketing:</strong> <a href="mailto:marketing@gadgethub.com">marketing@gadgethub.com</a></p>
                </div>

                <div class="contact-method">
                    <span class="contact-method-icon">⏰</span>
                    <h4>Business Hours</h4>
                    <p>Monday - Friday:9:00 AM - 6:00 PM</p>
                    <p>Saturday:10:00 AM - 4:00 PM</p>
                    <p>Sunday:Closed</p>
                </div>
            </div>
        </div>

        <!-- Office Locations -->
        <section class="locations-section">
            <h2 class="section-title">Our Office Locations</h2>
            <div class="locations-grid">
                <div class="location-card">
                    <div class="location-icon">🏢</div>
                    <h4>North America HQ</h4>
                    <p>One Microsoft Way</p>
                    <p>Redmond, WA 98052</p>
                    <p>United States</p>
                    <p style="margin-top:10px; color:#00d9ff;">📞 +1 (425) 555-0100</p>
                </div>

                <div class="location-card">
                    <div class="location-icon">🌍</div>
                    <h4>European Office</h4>
                    <p>123 Tech Street</p>
                    <p>London, EC1A 1BB</p>
                    <p>United Kingdom</p>
                    <p style="margin-top:10px; color: #00d9ff;">📞 +44 20 7123 4567</p>
                </div>

                <div class="location-card">
                    <div class="location-icon">🌏</div>
                    <h4>Asia Pacific Office</h4>
                    <p>456 Innovation Drive</p>
                    <p>Singapore, 018956</p>
                    <p>Singapore</p>
                    <p style="margin-top:10px; color:#00d9ff;">📞 +65 6123 4567</p>
                </div>
            </div>
        </section>

        <!-- Social Media -->
        <section class="social-section">
            <h3>🌐 Connect With Us</h3>
            <div class="social-links">
                <a href="#" class="social-link" title="Facebook">📘</a>
                <a href="#" class="social-link" title="Twitter">🐦</a>
                <a href="#" class="social-link" title="LinkedIn">💼</a>
                <a href="#" class="social-link" title="Instagram">📷</a>
                <a href="#" class="social-link" title="YouTube">🎥</a>
                <a href="#" class="social-link" title="GitHub">💻</a>
            </div>
        </section>

        <!-- FAQ Section -->
        <section class="faq-section">
            <h2 class="section-title">Frequently Asked Questions</h2>
            
            <div class="faq-item">
                <div class="faq-question">❓ How long does it take to get a quotation?</div>
                <div class="faq-answer">
                    Our system sends quotation requests to all distributors simultaneously.
                    You typically receive multiple quotes within minutes, allowing you to compare and choose the best option.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">❓ What payment methods do you accept?</div>
                <div class="faq-answer">
                    We accept all major credit cards, PayPal, bank transfers, and cryptocurrency payments.
                    All transactions are secured with industry-standard encryption.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">❓ Can I track my order?</div>
                <div class="faq-answer">
                    Yes! Once your order is approved and shipped, you'll receive real-time tracking information.
                    You can monitor your order status directly from your account dashboard.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">❓ What is your return policy?</div>
                <div class="faq-answer">
                    We offer a 30-day return policy on all products.Items must be in original condition with all packaging. 
                    Contact our support team to initiate a return.
                </div>
            </div>
        </section>
    </main>
</asp:Content>
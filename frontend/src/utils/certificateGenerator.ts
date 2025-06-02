// @ts-ignore
import html2pdf from 'html2pdf.js'

interface CertificateData {
  studentName: string
  courseName: string
  courseType: string
  completionDate: string
  duration: number
}

export const generateCertificate = (data: CertificateData) => {
  // Стильный сертификат с увеличенными размерами текста
  const certificateHTML = `
    <!DOCTYPE html>
    <html lang="ru">
    <head>
      <meta charset="UTF-8">
      <style>
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        
        body {
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          background: #8962D0;
          width: 210mm;
          height: 297mm;
          margin: 0;
          padding: 0;
          overflow: hidden;
        }
        
        .certificate {
          width: 210mm;
          height: 297mm;
          background: #8962D0;
          color: white;
          padding: 60px 50px;
          display: flex;
          flex-direction: column;
          position: relative;
          overflow: hidden;
        }
        
        .header {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin-bottom: 50px;
          flex-shrink: 0;
          position: relative;
          z-index: 10;
        }
        
        .logo {
          font-size: 36px;
          font-weight: 300;
          opacity: 0.9;
        }
        
        .cert-type {
          font-size: 20px;
          font-weight: 300;
          opacity: 0.7;
          text-align: right;
        }
        
        .main-content {
          flex: 1;
          display: flex;
          flex-direction: column;
          justify-content: center;
          max-width: 100%;
          text-align: left;
          position: relative;
          z-index: 10;
        }
        
        .confirms-text {
          font-size: 28px;
          font-weight: 300;
          opacity: 0.8;
          margin-bottom: 40px;
          position: relative;
        }
        
        .student-name {
          font-size: 88px;
          font-weight: 700;
          line-height: 0.9;
          margin-bottom: 60px;
          letter-spacing: -2px;
          position: relative;
        }
        
        .course-description {
          font-size: 24px;
          font-weight: 400;
          opacity: 0.9;
          margin-bottom: 30px;
          line-height: 1.4;
          word-spacing: 3px;
          letter-spacing: 0px;
        }
        
        .course-name {
          font-size: 44px;
          font-weight: 700;
          line-height: 1.2;
          letter-spacing: 0.5px;
        }
        
        /* Графические элементы */
        .decorative-elements {
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          pointer-events: none;
          z-index: 1;
        }
        
        .line-top {
          position: absolute;
          top: 120px;
          right: 50px;
          width: 200px;
          height: 2px;
          background: rgba(255, 255, 255, 0.2);
        }
        
        .line-bottom {
          position: absolute;
          bottom: 80px;
          left: 50px;
          width: 150px;
          height: 2px;
          background: rgba(255, 255, 255, 0.3);
        }
        
        .circle-1 {
          position: absolute;
          top: 40px;
          right: 80px;
          width: 60px;
          height: 60px;
          border: 2px solid rgba(255, 255, 255, 0.15);
          border-radius: 50%;
        }
        
        .circle-2 {
          position: absolute;
          bottom: 120px;
          right: 60px;
          width: 40px;
          height: 40px;
          background: rgba(255, 255, 255, 0.1);
          border-radius: 50%;
        }
        
        .triangle {
          position: absolute;
          top: 200px;
          left: 30px;
          width: 0;
          height: 0;
          border-left: 20px solid transparent;
          border-right: 20px solid transparent;
          border-bottom: 35px solid rgba(255, 255, 255, 0.1);
        }
        
        .diamond {
          position: absolute;
          bottom: 200px;
          left: 80px;
          width: 30px;
          height: 30px;
          background: rgba(255, 255, 255, 0.15);
          transform: rotate(45deg);
        }
        
        .accent-line {
          position: absolute;
          top: 300px;
          left: 50px;
          width: 180px;
          height: 3px;
          background: linear-gradient(90deg, rgba(255,255,255,0.3) 0%, rgba(255,255,255,0.6) 50%, rgba(255,255,255,0.3) 100%);
        }
        
        .corner-accent {
          position: absolute;
          bottom: 40px;
          right: 40px;
          width: 80px;
          height: 80px;
          border: 3px solid rgba(255, 255, 255, 0.2);
          border-radius: 10px;
          transform: rotate(15deg);
        }
      </style>
    </head>
    <body>
      <div class="certificate">
        <div class="decorative-elements">
          <div class="line-top"></div>
          <div class="line-bottom"></div>
          <div class="circle-1"></div>
          <div class="circle-2"></div>
          <div class="triangle"></div>
          <div class="diamond"></div>
          <div class="accent-line"></div>
          <div class="corner-accent"></div>
        </div>
        
        <div class="header">
          <div class="logo">Soft Skill</div>
          <div class="cert-type">/ сертификат</div>
        </div>
        
        <div class="main-content">
          <div class="confirms-text">подтверждает, что</div>
          
          <div class="student-name">${data.studentName}</div>
          
          <div class="course-description">
            успешно&nbsp;&nbsp;завершил (а)&nbsp;курс&nbsp;и&nbsp;изучил (а)<br>
            соответствующие&nbsp;&nbsp;&nbsp;информационные<br>
            материалы&nbsp;&nbsp;на&nbsp;платформе&nbsp;&nbsp;Soft&nbsp;Skill
          </div>
          
          <div class="course-name">${data.courseName}</div>
        </div>
      </div>
    </body>
    </html>
  `

  // Оптимизированные настройки для одной страницы
  const options = {
    margin: 0,
    filename: `Сертификат_${data.studentName.replace(/\s+/g, '_')}.pdf`,
    image: { type: 'jpeg', quality: 0.98 },
    html2canvas: { 
      scale: 1.5,
      useCORS: true,
      allowTaint: true,
      logging: false,
      width: 794,
      height: 1123,
      scrollX: 0,
      scrollY: 0
    },
    jsPDF: { 
      unit: 'mm', 
      format: 'a4', 
      orientation: 'portrait'
    }
  }

  // Генерируем PDF
  html2pdf()
    .set(options)
    .from(certificateHTML)
    .save()
    .catch((error: any) => {
      console.error('Ошибка генерации сертификата:', error)
      alert('Произошла ошибка при создании сертификата')
    })
} 
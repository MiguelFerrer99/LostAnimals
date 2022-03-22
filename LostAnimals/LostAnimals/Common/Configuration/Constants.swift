//
//  Constants.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

// MARK: - Constants
struct Constants {
    // MARK: - Properties
    static let emptyUser = User(id: "",
                                email: "",
                                animalShelter: false,
                                firstname: "",
                                lastname: "",
                                birthdate: Date.today.toString(withFormat: DateFormat.dayMonthYearOther),
                                userImage: UIImage(named: "DefaultUserImage") ?? UIImage(),
                                headerImage: UIImage(named: "DefaultHeaderImage") ?? UIImage(),
                                location: Location(address: "Not specified", coordinates: nil),
                                socialMedias: [:],
                                banned: false,
                                blockedUsers: [])
    
    static let onboardingStepsInfo = [
        OnboardingStepInfo(title: "Share",
                           description: "Have you lost your pet? We help you to find her by sharing information. Everyone stay tuned! 👀",
                           image: UIImage(named: "OnboardingItem1") ?? UIImage()),
        OnboardingStepInfo(title: "Find",
                           description: "Have you seen an abandoned pet? Share it so everyone knows where and when have you seen it 🔍",
                           image: UIImage(named: "OnboardingItem2") ?? UIImage()),
        OnboardingStepInfo(title: "Contact",
                           description: "Contact people easily through their social networks to solve everything 📞",
                           image: UIImage(named: "OnboardingItem3") ?? UIImage())
    ]
    
    static let termsAndConditions = [
        TermAndCondition(title: """
            Gracias por usar LostAnimals
            
            """, description: "Para el buen funcionamiento de la comunidad, necesitamos que sigas los Términos y Condiciones de uso propuestos, los cuales serán aplicables a los usuarios a partir del 1 de marzo del 2022."),
        TermAndCondition(title: "Términos y Condiciones de uso de LostAnimals", description: """
            Los presentes Términos y Condiciones de uso establecen las condiciones bajo las cuales se ofrece a los usuarios el acceso a los sitios web, servicios y aplicaciones de LostAnimals, que es una plataforma que permite a los usuarios encontrar sus animales perdidos de una manera mucho más rápida y eficaz gracias al uso de las nuevas tecnologias. El uso del Servicio atribuye a quien lo realiza la condición de usuario del mismo e implica la aceptación íntegra de estos Términos y Condiciones. En caso de no estar de acuerdo con todo o parte de estos Términos y Condiciones, el Usuario debe abstenerse de instalar y utilizar el Servicio. Por medio de la aceptación de los presentes Términos y Condiciones, el Usuario manifiesta:
            - Que ha leído, entiende y comprende lo aquí expuesto.
            - Que asume todas las obligaciones aquí dispuestas.
            - Que es mayor de edad y tiene la capacidad legal suficiente para utilizar el Servicio.
            - La aceptación de estos Términos y Condiciones por parte de los Usuarios es un paso previo e indispensable a la utilización del Servicio.
            LostAnimalsse reserva el derecho a actualizar y/o modificar los Términos y Condiciones en cualquier momento y por cualquier motivo a su exclusiva discreción. LostAnimals notificará acerca de cualquier cambio material en los Términos y Condiciones o en cualquier Servicio u otra función de los Servicios. Al acceder o usar los Servicios después de que LostAnimalshaya notificado al Usuario sobre una modificación o actualización, el Usuario acepta quedar obligado por los Términos y Condiciones modificados. Si los Términos y Condiciones modificados no resultan aceptables al Usuario, su única opción es dejar de utilizar los Servicios.
            """),
        TermAndCondition(title: "Titular del servicio", description: "El titular y propietario del Servicio es Miguel Ferrer Fornali. Email: miguelferrerfornali1999@gmail.com"),
        TermAndCondition(title: "Necesidad de registro", description: "Para poder utilizar el Servicio es necesario el previo registro del Usuario, la aceptación de los presentes Términos y Condiciones y la Política de Privacidad y de cookies. Los datos introducidos por el Usuario deberán ser exactos, actuales y veraces. El Usuario registrado será responsable en todo momento de la custodia de su contraseña, asumiendo en consecuencia cualesquiera daños y perjuicios que pudieran derivarse de su uso indebido, así como de la cesión, revelación o extravío de la misma, debiendo informar inmediatamente a LostAnimalsen caso de que tenga motivos para creer que su contraseña ha sido utilizada de manera no autorizada o es susceptible de serlo. En cualquier caso, se considera que el Usuario es responsable por el acceso y/o uso del Servicio en relación con su cuenta, quien responderá en todo caso de dicho acceso y/o uso. Mediante la aceptación de los Términos y Condiciones, el Usuario consiente que sus datos pasen a formar parte del fichero de LostAnimalsy el tratamiento de esos datos será conforme a lo previsto en la Política de Privacidad."),
        TermAndCondition(title: "Normas de utilización del servicio", description: """
            El Usuario se obliga a utilizar el Servicio conforme a lo establecido en la ley, la moral, el orden público y los presentes Términos y Condiciones. Asimismo, se obliga a hacer un uso adecuado del Servicio y a no emplearlo para realizar actividades ilícitas o constitutivas de delito, que atenten contra los derechos de terceros o que infrinjan cualquier norma del ordenamiento jurídico. El Usuario se obliga a no transmitir, introducir, difundir y/o poner a disposición de terceros, cualquier tipo de material e información que sean contrarios a la ley, la moral, el orden público y los presentes Términos y Condiciones. A título enunciativo y en ningún caso limitativo o excluyente, el Usuario se compromete a:
            - No introducir o difundir contenidos o propaganda de carácter racista, xenófobo, pornográfico, de apología del terrorismo, conflicto armado, incitación al odio o que atenten contra los derechos humanos.
            - No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido que atente contra los derechos fundamentales y las libertades públicas reconocidos constitucionalmente y en los tratados internacionales.
            - No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido que constituya publicidad ilícita o desleal.
            - No transmitir publicidad no solicitada o autorizada, material publicitario, “correo basura”, “cartas en cadena”, “estructuras piramidales”, o cualquier otra forma de solicitud.
            - No introducir o difundir cualquier información y contenidos falsos, engañosos, ambiguos o inexactos de forma que induzca o pueda inducir a error a los receptores de la información.
            - No suplantar a otros Usuarios del Servicio.
            - No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido sin autorización de los titulares de los derechos de propiedad intelectual e industrial que puedan recaer sobre tal información, elemento o contenido.
            - No difundir, transmitir o poner a disposición de terceros cualquier tipo de información, elemento o contenido que suponga una violación del secreto de las comunicaciones y la legislación de datos de carácter personal.
            - No difundir, transmitir o poner a disposición de terceros fotografías ni cualquier representación o imagen de personas menores de edad.
            - No reportar falsamente o incorrectamente de forma reiterada.
            - Usar los servicios de LostAnimals correctamente.
            El Usuario se obliga a mantener indemne a LostAnimals ante cualquier posible reclamación, multa, pena o sanción que pueda venir obligada a soportar como consecuencia del incumplimiento por parte del Usuario de cualquiera de las normas de utilización antes indicadas, reservándose además LostAnimals el derecho a solicitar la indemnización por daños y perjuicios que corresponda.
            """),
        TermAndCondition(title: "Exclusión de Usuarios", description: "LostAnimals se reserva el derecho a impedir el uso del Servicio, ya sea de forma temporal o definitiva, a cualquier Usuario que infrinja cualquiera de las normas establecidas en estos Términos y Condiciones, la ley o la moral. Discrecionalmente, LostAnimals también podrá excluir Usuarios e incluso dejar de prestar total o parcialmente el Servicio cuando así lo considere oportuno para mejorar la operativa del Servicio y/o del resto de los Usuarios del mismo."),
        TermAndCondition(title: "Exclusión de responsabilidad", description: """
            LostAnimals no es propietaria de ninguno de las mascotas difundidas a través de su plataforma y no es parte del proceso de intercambio o adopción, ni revisa o valida las mascotas que los Usuarios difunden a través del Servicio, por lo que LostAnimals no será responsable, ni directa ni indirectamente, ni subsidiariamente, de los daños y perjuicios de cualquier naturaleza derivados de la utilización y contratación de los contenidos y de las actividades de los Usuarios y/o de terceros a través del Servicio así como de la falta de licitud, fiabilidad, utilidad, veracidad, exactitud, exhaustividad y actualidad de los mismos. Con carácter enunciativo, y en ningún caso limitativo, LostAnimals no será responsable por los daños y perjuicios de cualquier naturaleza derivados de:
            - La utilización que los Usuarios hagan del Servicio ni por el estado, origen, posible inexactitud, o posible falsedad de los datos proporcionados por los Usuarios ni de los productos ofrecidos a través del Servicio.
            - Los contenidos, informaciones, opiniones y manifestaciones de cualquier Usuario o de terceras personas o entidades que se comuniquen o exhiban a través del Servicio.
            - La utilización que los Usuarios puedan hacer de los materiales del Servicio, ya sean prohibidos o permitidos, en infracción de los derechos de propiedad intelectual y/o industrial, información confidencial, de contenidos del Servicio o de terceros.
            - La realización de actos de competencia desleal y publicidad ilícita.
            - La eventual pérdida de datos de los Usuarios por causa no atribuible al Servicio.
            - El acceso de menores de edad a los contenidos incluidos en el Servicio.
            - La indisponibilidad, errores, fallos de acceso y falta de continuidad del Servicio.
            - Los fallos o incidencias que pudieran producirse en las comunicaciones, borrado o transmisiones incompletas.
            - La no operatividad o problemas en la dirección de email facilitada por el Usuario.
            LostAnimals responderá única y exclusivamente frente al Usuario de los Servicios que preste por sí misma y de los contenidos directamente originados e identificados con su copyright.
            Cualquier reclamación o controversia que pueda surgir entre los Usuarios del Servicio deberá ser solventada entre éstos, obligándose a mantener a LostAnimals totalmente indemne, sin perjuicio de lo cual LostAnimals realizará sus mejores esfuerzos para facilitar a los Usuarios una pronta y satisfactoria solución a través de su Servicio de Atención al Usuario.
            """),
        TermAndCondition(title: "Contenidos y servicios enlazados a través del Servicio", description: "El Servicio puede incluir dispositivos técnicos de enlace, directorios e incluso instrumentos de búsqueda que permitan al Usuario acceder a otras páginas y portales de internet. El Usuario reconoce y acepta que el acceso a los Sitios Enlazados será bajo su exclusivo riesgo y responsabilidad y exonera a LostAnimals de cualquier responsabilidad sobre eventuales vulneraciones de derechos de propiedad intelectual o industrial de los titulares de los Sitios Enlazados. Asimismo, el Usuario exonera a LostAnimals de cualquier responsabilidad sobre la disponibilidad técnica de las páginas web enlazadas, la calidad, fiabilidad, exactitud y/o veracidad de los servicios, informaciones, elementos y/o contenidos a los que el Usuario pueda acceder. En estos casos, LostAnimals solo será responsable de los contenidos y servicios suministrados en los Sitios Enlazados en la medida en que tenga conocimiento efectivo de la ilicitud y no haya desactivado el enlace con la diligencia debida. En el supuesto de que el Usuario considere que existe un Sitio Enlazado con contenidos ilícitos o inadecuados podrá comunicárselo a LostAnimals, sin que en ningún caso esta comunicación conlleve la obligación de retirar el correspondiente enlace. En ningún caso, la existencia de Sitios Enlazados debe presuponer la formalización de acuerdos con los responsables o titulares de los mismos, ni la recomendación, promoción o identificación de LostAnimals con las manifestaciones, contenidos o servicios proveídos. LostAnimals no conoce los contenidos y servicios de los Sitios Enlazados y, por tanto, no se hace responsable de forma directa o indirecta por los daños producidos por la ilicitud, calidad, desactualización, indisponibilidad, error e inutilidad de los contenidos y/o servicios de los Sitios Enlazados ni por cualquier otro daño que no sea directamente imputable a LostAnimals."),
        TermAndCondition(title: "Propiedad intelectual e industrial", description: "Los derechos de propiedad industrial e intelectual sobre las obras, prestaciones protegidas y cualesquiera contenidos o elementos sobre los que recaigan derechos de propiedad intelectual e industrial que se usen en el Servicio pertenecen a sus legítimos titulares. El Usuario no adquirirá por el uso del Servicio ningún derecho de propiedad intelectual o industrial, ni licencia de uso alguna sobre tales elementos. Son Contenidos del Servicio, los textos, fotografías, gráficos, imágenes, iconos, tecnología, software, bases de datos, y demás contenidos audiovisuales o sonoros, así como su diseño gráfico y códigos fuente utilizados en el Servicio. Esta enumeración se realiza a título enunciativo y ejemplificativo, no limitativo. El texto, las imágenes, los gráficos, los ficheros de sonido, los ficheros de animación, los ficheros de vídeo, el software y la apariencia del sitio web de LostAnimals son objeto de protección por derechos de propiedad intelectual e industrial. Esos elementos no podrán ser válida y legítimamente copiados o distribuidos para uso comercial, ni podrán ser modificados o insertados en otros sitios web sin previa autorización expresa de sus titulares. El Usuario manifiesta ser titular en exclusiva de todos los derechos que recaen sobre las obras, prestaciones protegidas y cualesquiera otros elementos protegidos por propiedad intelectual o industrial que incorpore en el Servicio. El Usuario cede gratuitamente y en exclusiva a LostAnimals los derechos de comunicación pública, reproducción, distribución y transformación que tiene sobre los Contenidos, en todas las modalidades de explotación existentes en la fecha de aceptación de estos Términos y Condiciones, por todo el tiempo de vigencia de los derechos objeto de cesión, para el ámbito territorial universal."),
        TermAndCondition(title: "Publicación de anuncios de búsqueda y adopción de mascotas", description: """
            "A la hora de publicar sus anuncios de búsqueda y adopción de mascotas el Usuario deberá tener en cuenta algunas consideraciones, incluyendo las siguientes:
            - No está permitido publicar imágenes o descripciones que no se correspondan con la mascota anunciada.
            - Solo se permite anunciar una mascota por anuncio.
            - No está permitido publicar anuncios con imágenes de contenido sexual.
            - No está permitido publicar imágenes de menores de edad.
            En cualquier caso, a la hora de publicar sus anuncios el Usuario deberá tomar en consideración las reglas de publicación.
            Por su parte, el Usuario interesado en adoptar una mascota debe tener en cuenta que LostAnimals es una aplicación que actúa como mero intermediario y no interviene en el proceso de adopción. LostAnimals no es propietaria de ninguna de las mascotas. LostAnimals no revisa ni valida la veracidad de los anuncios que los Usuarios difunden a través del servicio, por lo que LostAnimals no será en ningún caso responsable, ni directa ni indirectamente, ni subsidiariamente, de los daños y perjuicios de cualquier naturaleza, así como tampoco será responsable de la falta de licitud, fiabilidad, utilidad, veracidad, exactitud, exhaustividad y actualidad de los mismos.
            """),
        TermAndCondition(title: "Nulidad e ineficacia de las cláusulas", description: "Si cualquier cláusula incluida en los presentes Términos y Condiciones fuese declarada total o parcialmente, nula o ineficaz, tal nulidad o ineficacia tan solo afectará a dicha disposición o a la parte de la misma que resulte nula o ineficaz, subsistiendo los presentes Términos y Condiciones en todo lo demás, considerándose tal disposición total o parcialmente por no incluida."),
        TermAndCondition(title: "Legislación aplicable y jurisdicción competente", description: "Estos Términos y Condiciones se regirán e interpretarán conforme a la legislación española. En caso de litigio entre LostAnimals y el Usuario, éste podrá interponer su acción ante los tribunales españoles correspondientes al domicilio de LostAnimals , o bien ante los tribunales del lugar donde el Usuario esté domiciliado.")
    ]
    
    static let animalTypes: [AnimalType] = [
        .dog,
        .bird,
        .cat,
        .turtle,
        .snake,
        .rabbit,
        .other
    ]
}

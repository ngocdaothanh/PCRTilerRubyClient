require 'pcr_tiler_client'

#PCRTiler_BASE_URL = 'http://pcrtiler.alaingervais.org:8080/PCRTiler'
PCRTiler_BASE_URL = 'http://198.199.92.37:8080/PCRTiler'
puts PCRTiler_BASE_URL
puts

params = {
  'sequence' => 'ACCAATGGTGGCGCGATGTAACACGAGAAAGCACATACCAAGGCCACCACACACCACCTGTCCAAAAAGGCCTTCGATACGGGATAATCCTATTTATTACCTCAGAAGTTTTTTTCTTCGCAGGATTTTTCTGAGCCTTTTACCACTCCAGCCTAGCCCCTACCCCCCAACTAGGAGGGCACTGGCCCCCAACAGGCATCAACCAATGGTGGCGCGATGTAACACGAGAAAGCACATACCAAGGCCACCACACACCACCTGTCCAAAAAGGCCTTCGATACGGGATAATCCTATTTATTACCTCAGAAGTTTTTTTCTTCGCAGGATTTTTCTGAGCCTTTTACCACTCCAGCCTAGCCCCTACCCCCCAACTAGGAGGGCACTGGCCCCCAACAGGCATCAACCAATGGTGGCGCGATGTAACACGAGAAAGCACATACCAAGGCCACCACACACCACCTGTCCAAAAAGGCCTTCGATACGGGATAATCCTATTTATTACCTCAGAAGTTTTTTTCTTCGCAGGATTTTTCTGAGCCTTTTACCACTCCAGCCTAGCCCCTACCCCCCAACTAGGAGGGCACTGGCCCCCAACAGGCATCA',
  'organism' => 'Homo_sapiens'
}
puts params
puts

#id = PCRTiler.post_job(PCRTiler_BASE_URL, params)
#id = '2014y-3m-9d-7h-20m-38s-418r'
id = '2014y-3m-9d-5h-16m-52s-834r'
puts id
puts

result = PCRTiler.check_job(PCRTiler_BASE_URL, id)
puts result
puts